# -------------------------------------------------------------------
# General and Navigation
# -------------------------------------------------------------------

HOST_IP_ADDR=$(hostname -I | awk '{ print $1 }') # This gets the actual ip addr
export DEFAULT_WORK_DIR=$HOME/git/aladdin/feature1
export DEFAULT_SIF=$(cat $DEFAULT_WORK_DIR/env/GLOBAL_SIF)

function maybe_singularity_exec() {
    cmd=''
    if [ -z $SINGULARITY_CONTAINER ]; then
        cmd+="singularity exec $DEFAULT_SIF"
    fi
    echo $cmd
}

# Quick navigation add more here
# Started using worktrees in aladdin so updated here
alias am="cd ~/git/aladdin/master"
alias ab="cd ~/git/aladdin"
alias cde="cd /exp/$(whoami)"
alias core="cd /perish_aml02/$(whoami)/git/coreasr"
alias core2="cd /perish_aml02/$(whoami)/git/coreasr2"
alias cdg2="cd /perish_aml02/$(whoami)/git"
alias cdt="cd ~/tb"
alias cdn="cd ~/git/notebooks"
alias cds="cd ~/scripts"

# Perish machines
alias p1="cd /perish_aml01"
alias p2="cd /perish_aml02"
alias p3="cd /perish_aml03"
alias p4="cd /perish_aml04"
alias p5="cd /perish_aml05"
alias g1="cd /perish_g01"
alias g2="cd /perish_g02"
alias g3="cd /perish_g03"

alias b1="ssh b1"
alias b2="ssh b2"
alias b3="ssh b3"
alias b4="ssh b4"
alias b5="ssh b5"
alias b6="ssh b6"
alias b7="ssh b7"
alias b8="ssh b8"
alias b9="ssh b9"
alias b10="ssh b10"
alias b11="ssh b11"
alias b12="ssh b12"
alias b13="ssh b13"

# Activate aladdin master SIF in current directory
alias msam="/home/$(whoami)/git/aladdin/master/env/singularity.sh -c "$SHELL""
_get_dir() {
    if [ "$#" -eq 0 ]; then
        dir=$DEFAULT_WORK_DIR
    elif [ "$#" -eq 1 ]; then
        pushd $HOME/git/aladdin > /dev/null
        dir=$(git worktree list | awk '{print $1}' | grep "/$1$")
        popd > /dev/null
    fi
    echo $dir
}
msa() {
    dir=$(_get_dir $@)
    echo loading sif from $dir
    $dir/env/singularity.sh -c $SHELL
}
a() {
    dir=$(_get_dir $@)
    cd $dir
}
compdef a=msa

# Misc
function jp {
    jupyter lab --no-browser --ip $HOST_IP_ADDR
}
function jps() {
    $(maybe_singularity_exec) jp
}
function jpn(){
    pushd ~/git/notebooks/ &> /dev/null
    jps
    popd &> /dev/null
}

alias nv='nvidia-smi'
alias net="netron --host $HOST_IP_ADDR"

# make file
alias m='make'
alias mc="make check"
alias ms='make shell'
alias mf="make format"
alias mtest="make test"
alias mft="make functest"
alias mut="make unittest"

# docker
function jonah() { 
    docker run -v "$(readlink -f ./):/src" -v $HOME:$HOME --entrypoint bash -it $@
} # Enter docker
alias d='docker'
alias dcl='docker container ls'

# ls after every cd
function chpwd() {
 emulate -L zsh
 ls --group-directories-first 
}
alias ls="ls --color=auto --group-directories-first"

# remote debugging
open_tunnel() {
  host=$1
  remote_ip=$(ssh $host hostname -I | awk '{print $1}')
  echo "$remote_ip"
  ssh -2 -L 5678:$remote_ip:5678 $(whoami)@$host
}
compdef open_tunnel=ssh
# -------------------------------------------------------------------
# Tensorboard
# -------------------------------------------------------------------
function tb () {
    if [ "$#" -eq 0 ]; then
        logdir=$PWD
    else
        logdir=$1
    fi
    
    $(maybe_singularity_exec) tensorboard \
      --load_fast true \
      --host=$HOST_IP_ADDR \
      --reload_multifile true \
      --logdir=$logdir \
      --reload_interval 8 \
      --extra_data_server_flags=--no-checksum \
      --max_reload_threads 4 \
      --window_title $PWD |& grep -v "TensorFlow installation not found"
}

tblink () {
    # Creates simlinks from specified folders to ~/tb/x where x is an incrmenting number
    # and luanches tensorboard
    # example: `tblink ./lm/20210824 ./lm/20210824_ablation ./lm/20210825_updated_data`
    if [ "$#" -eq 0 ]; then
        logdir=$(pwd)
    else
        # setup tensorboard directory
        tbdir="$HOME/tb"
        if [ -d "$tbdir" ]; then
            last="$(printf '%s\n' $tbdir/* | sed 's/.*\///' | sort -g -r | head -n 1)"
            new=$((last+1))
            echo "last folder $last, new folder $new"
            logdir="$tbdir/$new"
        else
            logdir="$tbdir/0"
        fi
        # softlink into tensorboard directory
        _linkdirs "$logdir" "$@"
    fi
    tb $logdir
}
tbrunning () {
     jobs=$(qdesc | awk '{print $1}')
     args=()
     for job in ${=jobs}; do
         exp_dir="$(qexp "$job")"
         args+=($exp_dir)
     done
     tblink $args
 }
_linkdirs() {
    logdir="$1"
    mkdir -p $logdir
    for linkdir in "${@:2}"; do
        linkdir=$(readlink -f $linkdir)
        if [ ! -d $linkdir ]; then
            echo "linkdir $linkdir does not exist"
            return
        fi
        echo "symlinked $linkdir into $logdir"
        ln -s $linkdir $logdir
    done
}
tbadd() {
    # Add experiment folder to existing tensorboard directory (see tblink)
    # example: `tbadd ./lm/20210825 25` will symlink ./lm/20210824 to ~/tb/25
    if [ "$#" -gt 1 ]; then
        tbdir="$HOME/tb"
        logdir=$tbdir/$1
        _linkdirs $logdir "${@:2}"
    else
        echo "tbadd <tb number> <exp dirs>"
    fi
}

# -------------------------------------------------------------------
# Queue management
# -------------------------------------------------------------------

# Short aliases
full_queue='qstat -q "aml*.q@*" -f -u \*'
gpu_queue='qstat -q aml-gpu.q -f -u \*'
alias q='qstat'
alias qtop='qalter -p 1024'
alias qq=$full_queue # Display full queue
alias qu='qstat -q "aml*.q@*" -u ' # take username after
alias gq=$gpu_queue # Display just the gpu queues
alias gqf='qstat -q aml-gpu.q -u \* -r -F gpu | egrep -v "jobname|Master|Binding|Hard|Soft|Requested|Granted"' # Display the gpu queues, including showing the preemption state of each job
alias cq='qstat -q "aml-cpu.q@gpu*" -f -u \*' # Display just the cpu queues
alias wq="watch qstat"
alias wqq="watch $full_queue"
alias wgq="watch $gpu_queue"
alias qt="qtail"
alias qtf="qtail -f"
alias qtl="qtail -l"

compdef qalter=qstat

# Queue functions
qlogin () {
    # Function to request gpu or cpu access
    # example:
    #    qlogin 2                request 2 gpus
    #    qlogin 1 cpu            request 1 cpu slot
    #    qlogin 1 aml-gpu.q@b5   request 1 gpu on b5
    if [ "$#" -eq 1 ]; then
        /usr/bin/qlogin -now n -p 1024 -pe smp $1 -q aml-gpu.q -l gpu=$1 -N D_$(whoami)
    elif [ "$#" -eq 2 ]; then
        gpu_args=""
        if [ "$2" = "cpu" ]; then
            queue="aml-cpu.q"
        elif  echo "$2" | grep -q "gpu" ; then
            queue="$2"
            gpu_args="gpu=$1"
        else
            queue="$2"
        fi
        /usr/bin/qlogin -now n -p 1024 -pe smp $1 -q $queue -l "$gpu_args" -N D_$(whoami)
    else
        echo "Usage: qlogin <num_gpus>" >&2
        echo "Usage: qlogin <num_gpus> <queue>" >&2
        echo "Usage: qlogin <num_slots> cpu" >&2
    fi
}
qtail () {
    if [ "$#" -gt 0 ]; then
        l=$(qlog $@) && tail -f $l
    else
        echo "Usage: qtail <jobid>" >&2
        echo "Usage: qtail <array_jobid> <sub_jobid>" >&2
    fi
}
qlast () {
    # Get job_id of last running job
    job_id=$(qstat | awk '$5=="r" {print $1}' | grep -E '[0-9]' | sort -r | head -n 1)
    if [ ! -z $job_id ]; then
        echo $job_id
    else
        echo "no jobs found" >&2
    fi
}
qless () {
    less $(qlog $@)
}
qcat () {
    l=$(qlog $@) && cat $l
}
echo_if_exist() {
    [ -f $1 ] && echo $1
}
qlog () {
    # Get log path of job
    if [ "$1" = "-l" ]; then
        job_id=$(qlast)
    elif [ "$1" = "-f" ]; then
        job_id=$(qf)
        if [ "x$job_id" = "x" ]; then
            return 0
        fi
    else
        job_id=$1
    fi
    if [ "$#" -eq 1 ]; then
        echo $(qstat -j $job_id | grep stdout_path_list | cut -d ":" -f4)
    elif [ "$#" -eq 2 ]; then
        # Array jobs are a little tricky
        log_path=$(qlog $job_id)
        base_dir=$(echo $log_path | rev | cut -d "/" -f3- | rev)
        filename=$(basename $log_path)
        # Could be a number of schemes so just try them all
        echo_if_exist ${base_dir}/log/${filename} && return 0
        echo_if_exist ${base_dir}/log/${filename%.log}${2}.log && return 0
        echo_if_exist ${base_dir}/log/${filename%.log}.${2}.log && return 0
        echo_if_exist ${base_dir}/${filename%.log}.${2}.log  && return 0
        echo_if_exist ${base_dir}/${filename%.log}${2}.log && return 0
        echo "log file for array job $job_id $2 not found" >&2 && return 1
    else
        echo "Usage: qlog <jobid>" >&2
        echo "Usage: qlog <array_jobid> <sub_jobid>" >&2
    fi
}
qdesc () {
    # qstat | tail -n +3 | awk '{print $1" "$5}' | while read line; do
    #     id=$(echo $line | awk '{print $1}')
    #     job_status=$(echo $line | awk '{print $2}')
    #     log=$(qlog $id)
    #     echo $id $log $job_status
    # done
    qstat | tail -n +3 | while read line; do
        job=$(echo $line | awk '{print $1}')
        if [[ ! $(qstat -j $job | grep "job-array tasks") ]]; then
            job_status=$(echo $line | awk '{print $5}')
            echo $job $job_status $(qlog $job) 

        else
            qq_dir=$(qlog $job)
            job_status=$(echo $line | awk '{print $5}')
            if [ $job_status = 'r' ]; then
                sub_job=$(echo $line | awk '{print $10}')
                echo $job $sub_job $(qlog $job $sub_job)
            else
                echo $job $job_status $qq_dir 
            fi
        fi
    done
}
qexp () {
    # Get exp dir of job
    echo $(dirname $(qlog $1))
}
qrecycle () {
    [ ! -z $SINGULARITY_CONTAINER ] && ssh localhost "qrecycle $@" || command qrecycle "$@";
}
qupdate () {
    [ ! -z $SINGULARITY_CONTAINER ] && ssh localhost "qupdate"|| command qupdate ;
}
getfucked() {
    qstat -u "*" | grep $1 | awk '{print $1}' | while read job; do qmakep $job; done
}
qbump() {
    jobs=$(qdesc | awk '{print $1}')
    args=()
    for job in ${=jobs}; do
        qremovep $job
        qtop $job
    done
}
qall() {
    # Make any pendings jobs run on all queues
    jobs=$(qstat | grep qw |awk '{print $1}')
    args=()
    for job in ${=jobs}; do
        qalter $job -q aml-gpu.q@@a100,aml-gpu.q@b1,aml-gpu.q@b4,aml-gpu.q@b7
    done
}

compdef qlog=qstat
compdef qdel=qstat
compdef qcat=qstat
compdef qexp=qstat
compdef qrecycle=qstat
compdef qtail=qstat

# Only way to get a gpu is via queue
if [ -z $CUDA_VISIBLE_DEVICES ]; then
    export CUDA_VISIBLE_DEVICES=
fi
qf () {
    job_id=$(qdesc | fzf -m --ansi --header-lines=0 | awk '{print $1}')
    echo $job_id
}
fdel() {
    job_id=$(qf)

    if [ "x$job_id" != "x" ]; then
        echo "deleting $job_id"
        qdel $job_id
    fi
}
select_file() {
    given_file="$1"
    #fd --type file --follow --hidden --exclude .git | fzf --query="$given_file"
    fzf --query="$given_file"
}
nzero() {
    if [ "$#" -eq 0 ]; then
        dir=./
    else
        dir=$1
    fi
    for file in $(find $dir -name '*.log'); do
        if tail -n 1 $file | grep -q -P "status [1-9]+" ; then
            echo $file
            tail -n 5 $file
            echo \n
        fi
    done
}


# -------------------------------------------------------------------
# Cleaning processes
# -------------------------------------------------------------------

clean_vm () {
    kill_vscode
    ps -ef | grep '[z]sh' | awk '{print $2}' | xargs sudo kill
}
kill_vscode () {
    echo "killing vscode processes"
    ps -ef | grep '[v]scode' | awk '{print $2}' | xargs sudo kill
}
