#!/bin/bash
set -eo pipefail

. $DOT_DIR/zsh/utils.sh

cat << EOF > /tmp/git-script.sh
STASH_MSG=\$(git stash)
git branch $1 master
git checkout $1
git pull origin master
git push --set-upstream origin $1

# Only pop the stash if something was stashed
if [[ \$STASH_MSG != "No local changes to save" ]]; then
  git stash pop
fi
EOF

chmod u+x /tmp/git-script.sh
$(maybe_singularity_exec) /tmp/git-script.sh
rm /tmp/git-script.sh

