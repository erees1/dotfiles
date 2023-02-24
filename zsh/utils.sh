function add_to_path() {
    p=$1
    if [[ "$PATH" != *"$p"* ]]; then
      export PATH="$p:$PATH"
    fi
}
function maybe_singularity_exec() {
    cmd=''
    if [ -z $SINGULARITY_CONTAINER ]; then
        cmd+="$DEFAULT_WORK_DIR/env/singularity.sh exec"
    fi
    echo $cmd
}
