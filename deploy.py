"""
Script that reads a json file of source: destination paths and symlinks them.

If the json file is like:
"""
import argparse
import contextlib
import json
import sys
from pathlib import Path

def yellow(msg: str):
    return(f"\033[93m{msg}\033[0m")

def create_symlinks(json_file):
    with open(json_file, 'r') as f:
        path_mapping = json.load(f)

    skip_all = False
    overwrite_all = False

    for source, destination in path_mapping.items():
        source = Path(source).expanduser().resolve()
        destination = Path(destination).expanduser()

        if not source.exists():
            print(yellow(f"Source {source} does not exist. Skipping."))
            continue

        if destination.exists() or destination.is_symlink():
            if skip_all:
                print(f"Skipping: {destination}")
                continue
            elif overwrite_all:
                destination.unlink()
            else:
                choice = input(yellow(f"{destination} already exists. Skip [s], overwrite [o], skip all [S], or overwrite all [O]?: "))

                if choice == 'S':
                    skip_all = True
                elif choice == 'O':
                    overwrite_all = True
                if choice.lower() == 's':
                    print(f"Skipping: {destination}")
                    continue
                elif choice.lower() == 'o':
                    with contextlib.suppress(FileNotFoundError):
                        backup = destination.with_suffix(".bak")
                        backup.write_text(destination.read_text())
                    destination.unlink()
                else:
                    print("Invalid choice")
                    exit(1)

        try:
            destination.symlink_to(source)
            print(f"Created symlink: {source} -> {destination}")
        except Exception as e:
            print(f"Error creating symlink {source} -> {destination}: {str(e)}")


def setup_zshrc(include_homebrew: bool = False):
    zshrc_path = Path.home() / ".zshrc"
    dotfiles_root = Path(__file__).parent
    # Create a .hushlogin file to disable the "Last login" message
    Path.home().joinpath(".hushlogin").touch()

    if include_homebrew:
        source_line = f"source {dotfiles_root}/zsh/brew"
        if Path(zshrc_path).exists():
            content = zshrc_path.read_text()
            if source_line not in content:
                with zshrc_path.open('w') as f:
                    f.write(f"{source_line}\n{content}")
        else:
            with zshrc_path.open('w') as f:
                f.write(f"{source_line}\n")

    source_line = f"source {dotfiles_root}/zsh/zshrc"
    if source_line not in zshrc_path.read_text():
        with zshrc_path.open('a') as f:
            f.write(f"{source_line}\n")

def main():
    parser = argparse.ArgumentParser(description="Create symlinks based on a JSON file")
    parser.add_argument("json_file", help="Path to the JSON file containing source:destination mappings")
    parser.add_argument("--homebrew", action="store_true", help="Include homebrew setup in zshrc")
    args = parser.parse_args()

    json_file = Path(args.json_file)
    if not json_file.is_file():
        print(f"Error: File {json_file} not found")
        sys.exit(1)

    setup_zshrc(include_homebrew=args.homebrew)
    create_symlinks(json_file)

if __name__ == '__main__':
    main()
