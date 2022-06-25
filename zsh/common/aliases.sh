# -------------------------------------------------------------------
# personal
# -------------------------------------------------------------------

alias cdg="cd ~/git"
alias spy="tail -f"
alias zrc="cd $DOT_DIR/zsh"
alias dot="cd $DOT_DIR"
alias mkve="virtualenv -p python3"
alias jpl="jupyter lab"
alias mkipy="python -m ipykernel install --user --name"
alias rmipy="jupyter kernelspec uninstall"
alias vdot="nvim $DOT_DIR"
alias pydebug="python3 -m debugpy --listen 5678 --wait-for-client"

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
alias cl="clear"

# file and directories
alias rm='rm -i'
alias rmd='rm -rf'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# find/read files
alias h='head'
alias t='tail'
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
alias p="python"
alias p3="python3"
alias p2="python2"

fkill() {
    pid=$(ps -ef | sed 1d | fzf -m --ansi | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
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
alias .2='cd ../../'
alias .3='cd ../../../'
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

# ls after every cd
function chpwd() {
 emulate -L zsh
 ls
}

# cd into created directory
function mkcd () {
  case "$1" in /*) :;; *) set -- "./$1";; esac
  mkdir -p "$1" && cd "$1"
}

#-------------------------------------------------------------
# git
#-------------------------------------------------------------

alias g="git"
alias gcl="git clone"
alias ga="git add"
alias gaa="git add ."
alias gau="git add -u"
alias gc="git commit -m"
alias gcane='git commit --amend --no-edit'
alias gp="git push"
alias gpf="git push -f"

alias gg='git gui'
alias glog='git log --oneline --all --graph --decorate'

alias gf="git fetch"
alias gl="git pull"

alias grb="git rebase"
alias grbm="git rebase master"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias grba="git rebase --abort"

alias gm="git merge"
alias gmm="git merge master"
alias gmom="git pull --rebase=false origin master"

alias gd="git diff"
alias gdt="git difftool"
alias gs="git status"

alias gco="git checkout"
alias gcb="git checkout -b"
alias gcm="git checkout master"

alias grhead="git reset HEAD"
alias grewind="git reset HEAD^1"
alias grhard="git fetch origin && git reset --hard"

alias gst="git stash"
alias gstp="git stash pop"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstc="git stash clear"
alias gsts="git stash show -p"

alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

wt() {
    # function to change git worktrees easily
    directory=$(git worktree list | awk '{print $1}' | grep "/$1$")
    if [ ! -z $directory ]; then
	    echo Changing to worktree at: "$directory"
        cd $directory
    fi
}
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
alias ll="exa -bghla --git --color=automatic --group-directories-first"
alias la='ls -Al'         # show hidden files
alias lx='ls -lXB'        # sort by extension
alias lk='ls -lSr'        # sort by size, biggest last
alias lc='ls -ltcr'       # sort by and show change time, most recent last
alias lu='ls -ltur'       # sort by and show access time, most recent last
alias lt='ls -ltr'        # sort by date, most recent last
alias lm='ls -al |more'   # pipe through 'more'
alias lr='ls -lR'         # recursive ls
alias tree='tree -Csu'    # nice alternative to 'recursive ls'

#-------------------------------------------------------------
# chmod
#-------------------------------------------------------------

alias chw='chmod a+w'
alias chx='chmod u+x'

#-------------------------------------------------------------
# vim 
#-------------------------------------------------------------

vf () {
  file=$(fzf --height 40% --reverse)
  if [ "$file" != "" ]; then
    nvim $file
  fi
}
alias v="nvim"
alias vl="nvim -u ~/.config/nvim/init-light.lua --noplugin"
alias vim="nvim"
alias vimdiff='nvim -d'
export EDITOR=nvim
