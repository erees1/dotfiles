# dotfiles

Originally based on [holman/dotfiles](https://github.com/holman/dotfiles) and [trishume/dotfiles](https://github.com/trishume/dotfiles)

See also [a simpler version](https://github.com/erees1/simple-dotfiles) which I recomend as a more lightweight starting point.

## Components

There's a few special files in the hierarchy.

- `bin/`: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- `topic/*.zsh`: Any files ending in `.zsh` get loaded into your environment.
- `topic/*.env.zsh`: Any files ending in `env.zsh` get loaded first so that other config files can use these variables.
- `topic/*.install.sh`: Any files named `install.sh` get run when the root `./install.sh` is run. Used for installing dependencies. These files should handle whether you are on osx or linux and also respect the NO_ROOT env variable.

### Symlinks

- `config/*.json`: Contains a mapping of symlinks to create by `deploy.py`

## Install

Run this:

```bash
git clone git@github.com:erees1/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

If you are on linux and don't have root access run the following instead

```bash
NO_ROOT=1 ./install.sh
```

Then run:

```bash
python deploy.py config/<config_name>.json
```
