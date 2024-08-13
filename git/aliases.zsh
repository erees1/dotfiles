alias g="git"
alias gcl="git clone"
alias ga="git add"
alias gaa="git add ."
alias gau="git add -u"
alias gc="git commit -m"
alias gcn="git commit --no-verify -m"
alias gcane='git commit --amend --no-edit'
alias gca='git commit --amend'
alias gp="git push"
alias gpf="git push -f"

alias glog='git log --oneline --all --graph --decorate'

alias gf="git fetch"
alias gl="git pull"

alias grb="git rebase"
alias grbm="git rebase master"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias grba="git rebase --abort"

alias gm="git merge"
alias gmm='(git show-ref --verify --quiet refs/heads/main && git merge main) || (git show-ref --verify --quiet refs/heads/master && git merge main)'
alias gmom='(git show-ref --verify --quiet refs/heads/main && git pull --rebase=false origin main) || (git show-ref --verify --quiet refs/heads/master && git pull --rebase=false origin master)'

alias gd="git diff"
alias gdc="git diff --cached"
alias gdt="git difftool"
alias gs="git status"

alias gco="git checkout"
alias sw="git switch"
alias gcb="git checkout -b"
alias gcm='(git show-ref --verify --quiet refs/heads/main && git checkout main) || (git show-ref --verify --quiet refs/heads/master && git checkout master)'
alias swm='gcm'

alias grhead="git reset HEAD"
alias grewind="git reset HEAD^1"
alias grhard="git fetch origin && git reset --hard"

alias gst="git stash"
alias gstp="git stash pop"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstc="git stash clear"
alias gsts="git stash show -p"

alias ggsup='git branch --set-upstream-to=origin/$(git rev-parse --abbrev-ref HEAD)'
alias gpsup='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

alias garxv='git branch -m "arxv/$(git rev-parse --abbrev-ref HEAD)"&& git switch master'


wt() {
    # function to change git worktrees easily
    directory=$(git worktree list | awk '{print $1}' | grep "/$1$")
    if [ ! -z $directory ]; then
	    echo Changing to worktree at: "$directory"
        cd $directory
    fi
}

function whip() {
    # Get the last commit message
    last_commit_message=$(git log -1 --pretty=%B)

    # Check if the last commit message was 'wip'
    if [[ "$last_commit_message" == "wip" ]]; then
        # Commit with 'wip' message
        git commit --no-verify -m 'wip'

        # Perform an interactive rebase of the last two commits
        # and squash them together
        GIT_SEQUENCE_EDITOR='sed -i "2s/pick/squash/"' git rebase -i HEAD~2
    else
        # Just add and commit normally if the last message was not 'wip'
        git commit --no-verify -m 'wip'
    fi
}

git-recent() {
    # Show 10 most recent branches used in the last 10 days
    local count=${1:-10}
    git for-each-ref --color=always  --sort=-committerdate refs/heads/ --count=$count \
    --format='%(committerdate:short)|%(HEAD)|%(color:yellow)%(refname:short)%(color:reset)|(%(committerdate:relative))|-- %(contents:lines=1)' \
    | sed 's/\*/->/' | column -t -c 5 -s '|' | grep -E -v '(?:1[1-9]|[2-9]\d|\d{3,})\s*days'
}
git-switch-fzf() {
    selected=$(git-recent | fzf --ansi | sed 's/->/ /' | awk '{print $2}')
    if [ -n "$selected" ]; then
        echo "Switching to branch $selected"
        git switch $selected
    fi
}
alias gr='git-recent'
alias swf='git-switch-fzf'
