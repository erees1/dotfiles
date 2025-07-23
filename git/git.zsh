# git add ci and push
function git_prepare() {
   if [ -n "$BUFFER" ]; then
	BUFFER="git add -u && git commit -m \"$BUFFER\" "
   fi

   if [ -z "$BUFFER" ]; then
	BUFFER="git add -u && git commit -v "
   fi
		
   zle accept-line
}
zle -N git_prepare
bindkey -r "\eg"
bindkey "\eg" git_prepare

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

alias glog="git log --first-parent --color --format=format:'%C(yellow)%h %C(blue)%ad%C(auto)%d %C(reset)%s' --date=format:'%d-%m-%Y %H:%M:%S'"

alias gf="git fetch"
alias gl="git pull"
alias glh='git pull origin $(git rev-parse --abbrev-ref HEAD)'

alias grb="git rebase"
alias grbm="git rebase master"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias grba="git rebase --abort"

alias gm="git merge"
alias gmm='(git show-ref --verify --quiet refs/heads/main && git merge main) || (git show-ref --verify --quiet refs/heads/master && git merge main)'
alias gmom='(git show-ref --verify --quiet refs/heads/main && git pull --rebase=false origin main) || (git show-ref --verify --quiet refs/heads/master && git pull --rebase=false origin master)'
alias grom='(git show-ref --verify --quiet refs/heads/main && git pull --rebase=true origin main) || (git show-ref --verify --quiet refs/heads/master && git pull --rebase=true origin master)'
alias gros='git pull --rebase=true origin staging'

alias gd="git diff"
alias gdc="git diff --cached"
alias gdt="git difftool"
alias gs="git status"


alias grhead="git reset HEAD"
alias grewind="git reset HEAD^1"
alias grhard="git fetch origin && git reset --hard"

alias gstp="git stash pop"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstc="git stash clear"
alias gsts="git stash show -p"

alias gbd="git branch -D"

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
sw() {
    # If args are passed then call sw-and-stash
    if [[ $# -gt 0 ]]; then
        sw-and-stash "$@"
        return
    fi
    selected=$(git-recent | fzf --ansi | sed 's/->/ /' | awk '{print $2}')
    if [ -n "$selected" ]; then
        sw-and-stash $selected
    fi
}
alias gr='git-recent'

# Function to automatically stash and apply changes when switching branches
sw-and-stash() {
     
    # Ensure we have a branch name
    if [[ $# -lt 1 ]]; then
        echo "Usage: sw <branch>"
        return 1
    fi
    
    # If arg starts with - and is not just "-", pass directly to git switch
    if [[ $1 =~ ^- ]] && [[ $1 != "-" ]]; then
        git switch "$@"
        return
    fi
    
    local current_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    local target_branch=$1
    
    # Check if we're in a git repository
    if [[ $? -ne 0 ]]; then
        echo "Not in a git repository"
        return 1
    fi
    
    # Skip if switching to the same branch
    if [[ $current_branch == $target_branch ]]; then
        git checkout "$target_branch"
        return
    fi
    
    # Check if we have changes to stash
    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo "Auto-stashing changes for branch: $current_branch"
        git stash push -m "autostash-$current_branch" >/dev/null
    fi
    
    # Switch to the target branch
    git checkout "$target_branch"
    
    # If checkout was successful, check for existing autostash
    if [[ $? -eq 0 ]]; then
        # Look for existing autostash for the target branch
        # Handle special case when target_branch is '-' (switch to previous branch)
        if [[ $target_branch == "-" ]]; then
            target_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if [[ $? -ne 0 ]]; then
                echo "Failed to determine current branch after switching with '-'"
                return 1
            fi
        fi
        
        local stash_index=$(git stash list | grep "autostash-$target_branch" | head -n 1 | cut -d: -f1)
        
        if [[ -n $stash_index ]]; then
            echo "Auto-applying stash for branch: $target_branch"
            git stash apply "$stash_index" >/dev/null 2>&1
            
            # If apply was successful, drop the stash
            if [[ $? -eq 0 ]]; then
                git stash drop "$stash_index" >/dev/null
            else
                echo "Warning: Could not apply stash automatically. Stash preserved."
            fi
        fi
    fi
}

alias gcm='(git show-ref --verify --quiet refs/heads/main && sw main) || (git show-ref --verify --quiet refs/heads/master && sw master)'
alias swm='gcm'

# Helper function to clean up orphaned autostashes
gs-cleanup() {
    local branches=$(git for-each-ref --format='%(refname:short)' refs/heads/)

    git stash list | grep "autostash-" | while read -r stash; do
        local stash_branch=$(echo "$stash" | sed -n 's/.*autostash-\(.*\)$/\1/p')

        if ! echo "$branches" | grep -q "^$stash_branch$"; then
            local stash_index=$(echo "$stash" | cut -d: -f1)
            echo "Removing orphaned autostash for deleted branch: $stash_branch"
            git stash drop "$stash_index"
        fi
    done
}

# List all autostashes
gs-list() {
    git stash list | grep "autostash-"
}

# Custom function for git checkout autocomplete
_git_checkout_local_branches() {
    local -a local_branches
    local_branches=(${(f)"$(git branch --format='%(refname:short)')"})
    _describe 'local branches' local_branches
}

# Override the default git-checkout completion
zstyle ':completion:*:*:git:*' user-commands checkout:'locally modified checkout command'
_git-checkout() {
    _git_checkout_local_branches
}
# Override the default git-switch completion
zstyle ':completion:*:*:git:*' user-commands switch:'locally modified switch command'
_git-switch() {
    _git_checkout_local_branches
}
# Override the sw function completion
compdef _git_checkout_local_branches sw
