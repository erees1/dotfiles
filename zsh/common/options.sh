#-------------------------------------------------------------
# zsh extra settings
#-------------------------------------------------------------

setopt RM_STAR_WAIT               # Wait when typing `rm *` before being able to confirm
setopt NO_BEEP                    # Don't beep on errors in ZLE
setopt HIST_REDUCE_BLANKS         # Remove superfluous blanks before recording entry.
setopt HIST_IGNORE_SPACE          # Don't record an entry starting with a space.
setopt HIST_NO_STORE              # Remove the history (fc -l) command from the history.
setopt EXTENDED_HISTORY           # Write the history file in the ":start:elapsed;command" format.
setopt HIST_SAVE_NO_DUPS          # Don't write duplicate entries in the history file.
setopt HIST_EXPIRE_DUPS_FIRST     # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS          # Do not display a line previously found.
setopt always_to_end
setopt list_ambiguous
export HISTSIZE=100000            # big big history
export HISTFILESIZE=100000        # big big history
export HISTTIMEFORMAT="%F %T "
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

