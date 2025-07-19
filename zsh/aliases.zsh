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

if [ "$(uname -s)" = "Darwin" ]; then
    alias vm='ssh vm'
    alias rl='greadlink -f'
    alias cdj='cd ~/git/jamming'
    alias cdn='cd ~/git/jamming/notebooks'
    alias jpl="jupyter lab"
    alias rm="grm -i"
    alias cp='gcp -i'
    alias mv='gmv -i'

    function chpwd() {
        emulate -L zsh
        eval $ls_command
    }
fi
