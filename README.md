# dotfiles

Follows the structure from [holman/dotfiles](https://github.com/holman/dotfiles) and [trishume/dotfiles](https://github.com/trishume/dotfiles)

See also [a simpler version](https://github.com/erees1/simple-dotfiles) which I recomend as a more lightweight starting point.

## Components

There's a few special files in the hierarchy.

- `bin/`: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- `topic/*.zsh`: Any files ending in `.zsh` get loaded into your environment.
- `topic/*.symlink`: Any files ending in `*.symlink` get symlinked into your `$HOME`. This is so you can keep all of those versioned in your dotfiles but still keep those autoloaded files in your home directory. These get symlinked in when you run  `./deploy.sh`.
- `topic.config/*.symlink`: Any files / folders under a `topic.config` folder get symlinked into your `$HOME/.config`. 
- `topic/*.env.zsh`: Any files ending in `env.zsh` get loaded first so that other config files can use these variables.
- `topic/*.install.sh`: Any files named `install.sh` get run when the root `./install.sh` is run. Used for installing dependencies.
- `topic/*.install_no_root.sh`: As above but will be run if `./install.sh --no-root` is run.


## Install

Run this:
```bash
git clone git@github.com:erees1/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

If you are on linux and don't have root access or want dependendcies installed in your home dir run this instead:
```bash
./install.sh --no-root
```

Then run:
```bash
./deploy.sh
```

Install tmux plugins with `ctrl+a I`
