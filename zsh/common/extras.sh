#-------------------------------------------------------------
# zsh extra settings
#-------------------------------------------------------------

setopt RM_STAR_WAIT  # Wait 10 seconds when doing rm *
setopt NO_BEEP       # No bell sound
skip_global_compinit=1   # Speeds up start time
setopt HIST_REDUCE_BLANKS  # Remove blank lines from history
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt EXTENDED_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt always_to_end
setopt list_ambiguous
export HISTSIZE=100000 # big big history
export HISTFILESIZE=100000 # big big history
zstyle ':completion:*' hosts off  # Don't autocomple ssh host names
 
# FZF options - might also affect fzf-lua extenstion in vim
export FZF_DEFAULT_OPTS='--color=16,bg:-1,bg+:15,hl:4,hl+:4,fg:-1,fg+:-1,gutter:-1,pointer:-1,marker:-1,prompt:1 --height 40% --reverse --color border:46 --border=sharp --prompt="➤  " --pointer="➤ " --marker="➤ "'

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
