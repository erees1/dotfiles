# dotfiles

Install dependancies (e.g. oh-my-zsh, homebrew etc...), can specify options to install specific programs: tmux, zsh, pyenv
```bash
# Install dependancies + tmux & zsh
./install.sh --tmux --zsh --nvim --delta
```

Deploy (e.g. source aliases for .zshrc, apply oh-my-zsh settings etc..)

```bash
./deploy.sh
```

Install tmux plugins with `ctrl+a I`

See also [a simpler version](https://github.com/erees1/simple-dotfiles) which I recomend as a more lightweight starting point.
