#!/bin/bash
set -eo pipefail

. $DOT_DIR/zsh/utils.sh

cat << EOF > /tmp/git-script.sh
git fetch origin master:master
git branch $1 master
git checkout $1
git push --set-upstream origin $1
EOF

chmod u+x /tmp/git-script.sh
$(maybe_singularity_exec) /tmp/git-script.sh
rm /tmp/git-script.sh
