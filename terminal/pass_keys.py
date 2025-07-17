#!/usr/bin/env python3
"""
pass_keys.py - A kitten for kitty that passes keys to vim when appropriate

This kitten checks if the current window is running vim. If it is, it passes
the key to vim. Otherwise, it performs the navigation in kitty.
"""

import re
from kittens.tui.handler import result_handler
from kitty.key_encoding import KeyEvent, parse_shortcut


def is_vim(window):
    """Check if the current window is running vim or nvim"""
    if window is None:
        return False
    
    fp = window.child.foreground_processes
    if fp is None:
        return False
    
    for p in fp:
        if p['cmdline']:
            cmd = ' '.join(p['cmdline'])
            if re.search(r'n?vim', cmd):
                return True
    return False


def encode_key_mapping(key_mapping):
    """Encode key mapping for sending to vim"""
    mods, key = parse_shortcut(key_mapping)
    event = KeyEvent(
        mods=mods,
        key=key,
        shift=bool(mods & 1),
        alt=bool(mods & 2),
        ctrl=bool(mods & 4),
        super=bool(mods & 8),
        hyper=bool(mods & 16),
        meta=bool(mods & 32),
    ).as_window_system_event()
    
    return event


def main(args):
    pass


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    """Handle the key press based on whether vim is running"""
    window = boss.window_id_map.get(target_window_id)
    direction = args[1]
    key_mapping = args[2]
    
    if is_vim(window):
        # Pass the key to vim
        encoded = encode_key_mapping(key_mapping)
        with open("/tmp/kitty.log", 'w') as fh:
            print(f"writing {encoded.key}", file=fh)
            print(f"{dir(encoded)}", file=fh)
        window.write_to_child(window.encoded_key(encoded))
        
    else:
        # Perform kitty navigation
        boss.active_tab.neighboring_window(direction)
