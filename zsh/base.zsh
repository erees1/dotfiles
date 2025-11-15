#-------------------------------------------------------------
# Environment setup (from env.zsh)
#-------------------------------------------------------------

autoload -Uz compinit
compinit

if [[ $0 == -*zsh* ]]; then
    # When sourced by Zsh
    ZSH_DOT_DIR=$(realpath "$(dirname "${(%):-%x}")")
elif [[ $0 == *bash* ]]; then
    # When sourced by Bash
    ZSH_DOT_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
else
    # When executed directly (not sourced)
    ZSH_DOT_DIR=$(realpath "$(dirname "$0")")
fi
export DOT_DIR=$(realpath "$ZSH_DOT_DIR"/../)

export PRO_BASE="$HOME/git"
export ZSH_PLUGINS_DIR="$HOME/.zsh/plugins"
export OH_MY_ZSH=$HOME/.oh-my-zsh

# These are an edited version of the default colors to better match the default mac colors
# Red executables, blue dirs and purple symlinks
export LS_COLORS='rs=0:di=01;34:ln=01;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=32:st=37;44:ex=00;31:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

export MYLSCOLORS='Exfxcxdxbxegedabagacad'

export BAT_THEME=gruvbox-dark

# Give lsp more memory
export NODE_OPTIONS="--max-old-space-size=12288 --max-semi-space-size=64"

export HISTSIZE=10000            # big big history
export HISTFILESIZE=10000        # big big history
export HISTTIMEFORMAT="%F %T "
export EDITOR=nvim                # of course

#-------------------------------------------------------------
# zsh extra settings
#-------------------------------------------------------------

unsetopt completealiases          # Complete aliases as if they were commands
setopt RM_STAR_WAIT               # Wait when typing `rm *` before being able to confirm
setopt NO_BEEP                    # Don't beep on errors in ZLE
setopt HIST_REDUCE_BLANKS         # Remove superfluous blanks before recording entry.
setopt HIST_IGNORE_SPACE          # Don't record an entry starting with a space.
setopt HIST_NO_STORE              # Remove the history (fc -l) command from the history.
setopt EXTENDED_HISTORY           # Write the history file in the ":start:elapsed;command" format.
setopt HIST_SAVE_NO_DUPS          # Don't write duplicate entries in the history file.
setopt HIST_EXPIRE_DUPS_FIRST     # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS          # Do not display a line previously found.
setopt INC_APPEND_HISTORY         # New lines are added to $HISTFILE incrementally, rather than waiting until the shell exits
setopt always_to_end
setopt list_ambiguous
zstyle ':completion:*' hosts off  # Don't autocomple ssh host names
ZSH_DISABLE_COMPFIX=true


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

#-------------------------------------------------------------
# Vi mode configuration
#-------------------------------------------------------------

# Activate vim mode.
bindkey -v

# You need these here otherwise if you go into normal mode and then back to insert
# mode the delete key doesn't work, on testing it seems I only need ^? in mac terminal but I kept both
# of suggested here: https://vi.stackexchange.com/questions/31671/set-o-vi-in-zsh-backspace-doesnt-delete-non-inserted-characters
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# Add keybindings for ctrl-b and ctrl-e to go to beginning/end of line in insert mode
bindkey -M viins '^U' beginning-of-line
bindkey -M viins '^E' end-of-line

# Add keybindings for ctrl-n and ctrl-p to work like up/down arrows
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey -M vicmd '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history

# 50ms for key sequences
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# Yank to the system clipboard
function vi-yank-yk {
    zle vi-yank
   echo "$CUTBUFFER" | yk 2> /dev/null
}
function vi-cut-yk {
    zle vi-delete-char
    echo "$CUTBUFFER" | yk 2> /dev/null
}
function vi-delete-yk {
    zle vi-delete
    echo "$CUTBUFFER" | yk 2> /dev/null
}

zle -N vi-yank-yk
zle -N vi-cut-yk
zle -N vi-delete-yk
bindkey -M vicmd 'y' vi-yank-yk
bindkey -M vicmd 'x' vi-cut-yk
bindkey -M vicmd 'd' vi-delete-yk

#-------------------------------------------------------------
# Key bindings
#-------------------------------------------------------------

# Accept zsh autosggestions with ctrl + space
# Make sure you don't have mac input source switch
bindkey '^ ' autosuggest-accept

function prepend-sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"
    CURSOR+=5
    zle reset-prompt
  fi
}
zle -N prepend-sudo
bindkey "\es" prepend-sudo

function copy-line {
  echo -n "$BUFFER" | yk 2> /dev/null
  zle -M "Copied: $BUFFER"
}
zle -N copy-line
bindkey '^Y' copy-line

#-------------------------------------------------------------
# Aliases and functions (from aliases.zsh)
#-------------------------------------------------------------

# -------------------------------------------------------------------
# general
# -------------------------------------------------------------------

# projects
alias cdg="cd ~/code"
alias dot="cd $DOT_DIR"
alias cot="cd ~/git/cot"

alias clear="echo 'get out of here with that clear nonsense'"
alias lc="SKIP=no-commit-to-branch pre-commit run --hook-stage commit"
alias lp="SKIP=no-commit-to-branch pre-commit run --hook-stage push"
alias lr="pre-commit run ruff --all-files"
alias lpa="SKIP=no-commit-to-branch pre-commit run -a --hook-stage push"

# file and directories
alias rmd='rm -rf'
alias mkdir='mkdir -p'
mva() {
    # Move to archive for safe deleting
    mkdir -p ~/.archive
    mv "$@" ~/.archive
}

alias c='cd'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

alias d='dirs -v'
alias 0='cd -0'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# alias to mv stuff on s3 use s5cmd cp then rm
s5mv() {
    if s5cmd cp "$1/*" "$2"; then
        s5cmd rm "$1/*"
    fi
}


#-------------------------------------------------------------
# chmod
#-------------------------------------------------------------

alias chw='chmod a+w'
alias chx='chmod u+x'

#-------------------------------------------------------------
# vim
#-------------------------------------------------------------

vs() {
    nvim /tmp/sratch-$(date +'%Y-%m-%d').txt
}
vp() {
    nvim /tmp/sratch-$(date +'%Y-%m-%d').py
}

act() {
    # if no pyenv binary is found, return
    if ! command -v pyenv &> /dev/null; then
        return
    fi
    if [[ -n $VIRTUAL_ENV ]]; then
        echo "Activating pyenv $(basename $VIRTUAL_ENV)"
        pyenv shell $(basename $VIRTUAL_ENV)
    else
        pyenv shell --unset
    fi
}

nv() {
    # hack to get pyenv to work with nvim
    act
  if [[ "$1" =~ '^(.+):([0-9]+):([0-9]+)$' ]]; then
    local file=${match[1]}
    local line=${match[2]}
    local col=${match[3]}
    command nvim +call\ cursor\($line,$col\) "$file" "${@:2}"
  elif [[ "$1" =~ '^(.+):([0-9]+)$' ]]; then
    local file=${match[1]}
    local line=${match[2]}
    command nvim +$line "$file" "${@:2}"
  else
    command nvim "$@"
  fi
}

alias vim="nv"
alias v="nv"

# Start nvim listening on server pipe
alias nvl='nvim --listen /Users/ed/.cache/nvim/server.pipe'


#-------------------------------------------------------------
# Mac specific
#-------------------------------------------------------------

alias vm='ssh vm'
alias rl='greadlink -f'
alias rm="grm -i"
alias cp='gcp -i'
alias mv='gmv -i'

function chpwd() {
    emulate -L zsh
    eval ls
}
