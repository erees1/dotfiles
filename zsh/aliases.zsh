# -------------------------------------------------------------------
# general
# -------------------------------------------------------------------

# projects
alias cdg="cd ~/code"
alias dot="cd $DOT_DIR"
alias cot="cd ~/git/cot"

alias clear="echo 'get out of here with that clear nonsense'"
alias l="SKIP=no-commit-to-branch pre-commit run --hook-stage push"
alias la="SKIP=no-commit-to-branch pre-commit run -a --hook-stage push"

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

nvim() {
    # hack to get pyenv to work with nvim
    act
    command nvim $argv
}
alias vim="nvim"
alias v="nvim"


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
