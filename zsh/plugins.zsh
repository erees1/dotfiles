function add_to_fpath() {
  p=$1
  if [[ "$fpath" != *"$p"* ]]; then
    fpath=($1 $fpath)
  fi
}
add_to_fpath $ZSH_PLUGINS_DIR/zsh-completions/src
add_to_fpath $ZSH_DOT_DIR/completions

# Enable menu selection for completions
zstyle ':completion:*' menu select

# Load plugins manually
[[ -f $ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f $ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source $ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f $ZSH_PLUGINS_DIR/powerlevel10k/powerlevel10k.zsh-theme ]] && source $ZSH_PLUGINS_DIR/powerlevel10k/powerlevel10k.zsh-theme

# set completion colors to be the same as `ls`, after theme has been loaded
[[ -z "$LS_COLORS" ]] || zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
export LSCOLORS=$MYLSCOLORS  # do after oh-my-zsh to override their setting