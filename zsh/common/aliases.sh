#!/bin/zsh

# -------------------------------------------------------------------
# personal
# -------------------------------------------------------------------

alias cdg="cd ~/git"
alias spy="tail -f"
alias zrc="cd ~/git/dotfiles/zsh"
alias dot="cd ~/git/dotfiles"
alias mkve="virtualenv -p python3"
alias jpl="jupyter lab"
alias mkipy="python -m ipykernel install --user --name"
alias rmipy="jupyter kernelspec uninstall"
alias vdot="nvim ${HOME}/git/dotfiles"

function ve () {
    if [ -f ./venv/bin/activate ]; then
        source ./venv/bin/activate
    fi
}
alias vd="deactivate source"
# -------------------------------------------------------------------
# general
# -------------------------------------------------------------------

alias zshrc="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# file and directories
alias rm='rm -i'
alias rmd='rm -rf'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# find/read files
alias h='head'
alias t='tail'
alias rl="readlink -f"
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias which='type -a'

# storage
alias du='du -kh' # file space
alias df='df -kTh' # disk space
alias usage='du -sh * 2>/dev/null | sort -rh'
alias dus='du -sckx * | sort -nr'

# processes
alias psg='ps -ef | grep -i $1'
alias scumbag="ps aux  --sort=-%cpu | grep -m 11 -v `whoami`"

# extract
alias tgz='tar -zxvf'
alias tbz='tar -jxvf'

# other
alias rs='rsync -pravhz'
alias hist='history | grep'
alias path='echo -e ${PATH//:/\\n}'
alias man="man -a"
alias busy="cat /dev/urandom | hexdump -C | grep "ca fe""
# alias j='jobs -l'
# alias ltx='pdflatex'
# alias x='xclip -sel clip'


#-------------------------------------------------------------
# cd
#-------------------------------------------------------------

alias c='cd'
alias ..='cd ..'
alias ...='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias /='cd /'

alias d='dirs -v'
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
# git
#-------------------------------------------------------------

alias g="git"
alias gcl="git clone"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gpf="git push -f"
# alias gpo="git push origin $(current_branch)"
# alias gpp='git push --set-upstream origin $(current_branch)'

alias gg='git gui'
alias glog='git log --oneline --all --graph --decorate'

alias gf="git fetch"
alias gl="git pull"

alias grb="git rebase"
alias grbm="git rebase master"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias grba="git rebase --abort"

alias gd="git diff"
alias gs="git status"

alias gco="git checkout"
alias gcb="git checkout -b"
alias gcm="git checkout master"

alias grhead="git reset HEAD^"
alias grhard="git fetch origin && git reset --hard"

alias gst="git stash"
alias gstp="git stash pop"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstc="git stash clear"

#-------------------------------------------------------------
# tmux
#-------------------------------------------------------------

alias ta="tmux attach"
alias taa="tmux attach -t"
alias tad="tmux attach -d -t"
alias td="tmux detach"
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"
alias tkill="tmux kill-server"
alias tdel="tmux kill-session -t"

#-------------------------------------------------------------
# ls
#-------------------------------------------------------------

alias l="ls -CF --color=auto"
alias ll="ls -l --group-directories-first"
alias la='ls -Al'         # show hidden files
alias lx='ls -lXB'        # sort by extension
alias lk='ls -lSr'        # sort by size, biggest last
alias lc='ls -ltcr'       # sort by and show change time, most recent last
alias lu='ls -ltur'       # sort by and show access time, most recent last
alias lt='ls -ltr'        # sort by date, most recent last
alias lm='ls -al |more'   # pipe through 'more'
alias lr='ls -lR'         # recursive ls
alias tree='tree -Csu'    # nice alternative to 'recursive ls'

# -------------------------------------------------------------------
# cantab
# -------------------------------------------------------------------

alias c19="ssh edwardr@code19.cantabresearch.com"
alias colo="ssh edwardr@cam2c01.farm.speechmatics.io"
alias aml="ssh edwardr@bastion.aml.speechmatics.io"

#-------------------------------------------------------------
# chmod
#-------------------------------------------------------------

chw () {
  if [ "$#" -eq 1 ]; then
    chmod a+w $1
  else
    echo "Usage: chw <dir>" >&2
  fi
}
chx () {
  if [ "$#" -eq 1 ]; then
    chmod a+x $1
  else
    echo "Usage: chx <dir>" >&2
  fi
}

#-------------------------------------------------------------
# vim 
#-------------------------------------------------------------
alias vim="nvim"
alias vimdiff='nvim -d'
export EDITOR=nvim
