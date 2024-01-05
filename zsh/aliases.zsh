# -------------------------------------------------------------------
# general
# -------------------------------------------------------------------

# projects
alias cdg="cd ~/git"
alias dot="cd $DOT_DIR"
alias cot="cd ~/git/cot"

alias vdot="nvim $DOT_DIR"
alias debugpy_listen="python3 -m debugpy --listen 5678 --wait-for-client"
alias enable_pyenv="source $ZSH_DOT_DIR/common/init_pyenv.sh"
alias cl="clear -x"
alias l="SKIP=no-commit-to-branch pre-commit run -a --hook-stage commit"
alias sfv="streamlit run streamlit_finetuning_data_viewer.py"
alias sv="streamlit run streamlit_viewer.py"

# file and directories
alias rmd='rm -rf'
alias mkdir='mkdir -p'
mva() {
    # Move to archive for safe deleting
    mkdir -p ~/.archive
    mv "$@" ~/.archive
}

# find/read files
alias h='head'
alias t='tail'
alias tf='tail -f'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias which='type -a'

# storage
alias du='du -kh'  # file space
alias df='df -kTh' # disk space
alias usage='du -sh * 2>/dev/null | sort -rh'

# other
alias rs='rsync -pravhz'
alias hist='history | grep'
alias path='echo -e ${PATH//:/\\n}'
alias man="man -a"
alias busy="cat /dev/urandom | hexdump -C | grep "ca fe""

fkill() {
    pid=$(ps -ef | sed 1d | fzf -m --ansi | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        echo "killing processes $pid"
        kill -${1:-9} $pid
    fi
}

#-------------------------------------------------------------
# cd
#-------------------------------------------------------------

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

# pro cd function, see https://github.com/trishume/pro
pd() {
  projDir=$(pro search $1)
  cd ${projDir}
}

#-------------------------------------------------------------
# ls
#-------------------------------------------------------------

alias ll="exa -bghla --color=automatic --group-directories-first"
alias ls="exa"

#-------------------------------------------------------------
# chmod
#-------------------------------------------------------------

alias chw='chmod a+w'
alias chx='chmod u+x'

#-------------------------------------------------------------
# vim
#-------------------------------------------------------------

alias v="nvim"
alias vim="nvim"
alias vimdiff='nvim -d'
vs() {
    nvim /tmp/sratch-$(date +'%Y-%m-%d').txt
}
vp() {
    nvim /tmp/sratch-$(date +'%Y-%m-%d').py
}

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
        exa
    }
fi
