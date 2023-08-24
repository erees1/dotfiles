#!/bin/bash
set -eo pipefail

function maybe_singularity_exec() {
    if [ $LOC == "remote" ]; then
        cmd=''
        if [ -z $SINGULARITY_CONTAINER ]; then
            cmd+="$DEFAULT_WORK_DIR/env/singularity.sh exec"
        fi
        echo $cmd
    fi
}

git show-ref --verify --quiet refs/remotes/origin/main
if [ $? -eq 0 ]; then
    main_name="main"
else
    main_name="master"
fi

cat << EOF > /tmp/git-script.sh
#!/bin/bash
STASH_MSG=\$(git stash)
git branch $1 $main_name
git checkout $1
git pull origin $main_name

# Only pop the stash if something was stashed
if [[ \$STASH_MSG != "No local changes to save" ]]; then
  git stash pop
fi
EOF

chmod u+x /tmp/git-script.sh
$(maybe_singularity_exec) /tmp/git-script.sh
rm /tmp/git-script.sh

