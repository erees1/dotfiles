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
alias gcm='(git show-ref --verify --quiet refs/heads/main && git checkout main) || (git show-ref --verify --quiet refs/heads/master && git checkout master)'

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