import re
import sys
import subprocess
import os
import logging
from pathlib import Path

# log to a file
logging.basicConfig(filename='/tmp/file_opener_hint.log', level=logging.DEBUG)

class FilePatternConverter:
    def __init__(self):
        self.pattern: str = r'File \"([^\"]+\.py)\", line (\d+)'

    def _match(self, text: str) -> re.Match | None:
        return re.match(self.pattern, text)

    def convert(self, text: str) -> str:
        m = self._match(text)
        if not m:
            return text
        return f"{m.group(1)}:{m.group(2)}"

class DebugPatternConverter(FilePatternConverter):
    def __init__(self):
        self.pattern: str = r'([^\s:][^\s:]+\.py)\((\d+)\)'

class DirectPatternConverter:
    def __init__(self):
        self.pattern: str = r'[^\s:][^\s:]+\.py:(\d+)(?::(\d+))?'

    def convert(self, text: str) -> str:
        return text

CONVERTERS = {
    "direct": DirectPatternConverter(),
    "file_line": FilePatternConverter(),
    "ipdb": DebugPatternConverter(),
}

def mark(text, args, Mark, extra_cli_args, *a):
    patterns_with_converters = [(CONVERTERS[key].pattern, key) for key in CONVERTERS.keys()]

    # Collect all matches first
    matches = []
    for regex_pattern, converter_name in patterns_with_converters:
        for m in re.finditer(regex_pattern, text):
            start, end = m.span()
            mark_text = text[start:end].replace('\n', '').replace('\0', '')
            matches.append((start, end, mark_text, converter_name))

    # Sort matches by start position
    matches.sort(key=lambda x: x[0])

    # Yield marks in order
    for mark_id, (start, end, mark_text, converter_name) in enumerate(matches):
        yield Mark(mark_id, start, end, mark_text, {
            'converter': converter_name,
        })

def handle_result(args, data, target_window_id, boss, extra_cli_args, *a):
    word = data['match'][0]
    groupdict = data['groupdicts'][0]
    converter = CONVERTERS[groupdict['converter']]
    converted = converter.convert(word)
    subprocess.run(["/usr/local/bin/zed", converted])
