# dotfiles

Install dependancies (e.g. oh-my-zsh, homebrew etc...), an optional flag `--noroot` indicates that you do not have root access and so avoids using sudo.
```bash
# If you have root access
./install.sh 

# No root access
./install.sh --noroot
```

Deploy (e.g. source aliases for .zshrc, apply oh-my-zsh settings etc..)

```bash
./deploy.sh remote  # Remote linux machine
./deploy.sh local   # Local mac machine
./deploy.sh UCL     # UCL machine (extra aliases)
```
