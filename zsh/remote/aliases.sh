# -------------------------------------------------------------------
# General and Navigation
# -------------------------------------------------------------------

HOST_IP_ADDR=$(hostname -I | awk '{ print $1 }') # This gets the actual ip addr
TENSOR_BOARD_SIF="oras://singularity-master.artifacts.speechmatics.io/tensorboard:20210213"

# Quick navigation add more here
alias cda="cd ~/git/aladdin"
alias cda2="cd ~/git/aladdin2"
alias cda3="cd ~/git/aladdin3"
alias cdh="cd ~/git/hydra"
alias cdvad="cd /perish_aml02/$(whoami)/vad_workspace"
alias cde="cd /exp/$(whoami)"
alias cdco="cd /perish_aml02/$(whoami)/coreasr"
alias cdt="cd ~/tb"
alias cdn="cd ~/notebooks"
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

# Change to aladdin directory and activate SIF
alias msa="make -C /home/$(whoami)/git/aladdin/ shell"
alias msa2="make -C /home/$(whoami)/git/aladdin2/ shell"
alias msa3="make -C /home/$(whoami)/git/aladdin3/ shell"
# Activate aladdin SIF in current directory
alias msad="/home/$(whoami)/git/aladdin/env/singularity.sh -c "$SHELL""
alias msad2="/home/$(whoami)/git/aladdin2/env/singularity.sh -c "$SHELL""
alias msad3="/home/$(whoami)/git/aladdin3/env/singularity.sh -c "$SHELL""

# Misc
alias jpl="jupyter lab --no-browser --ip $HOST_IP_ADDR"
alias ls='ls -hF --color' # add colors for filetype recognition
alias nv='nvidia-smi'

# make file
alias m='make'
alias mc="make check"
alias ms='make shell'
alias mf="make format"
alias mtest="make test"
alias mft="make functest"
alias mut="make unittest"

# -------------------------------------------------------------------
# Tensorboard
# -------------------------------------------------------------------

alias tb="singularity exec $TENSOR_BOARD_SIF tensorboard --host=$HOST_IP_ADDR --reload_multifile true --logdir=."
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
    for linkdir in "$@"; do
      linkdir=$(rl $linkdir)
      if [ ! -d $linkdir ]; then
          echo "linkdir $linkdir does not exist"
          return
      fi
      echo "linkdir: $linkdir"
      mkdir -p $logdir
      ln -s $linkdir $logdir
    done
  fi
  echo "logdir: $logdir"
  singularity exec "$TENSOR_BOARD_SIF" tensorboard --host=$HOST_IP_ADDR --reload_multifile true --logdir=$logdir
}
tbadd() {
  # Add experiment folder to existing tensorboard directory (see tblink)
  # example: `tbadd ./lm/20210825 25` will symlink ./lm/20210824 to ~/tb/25
  if [ "$#" -eq 2 ]; then
    tbdir="$HOME/tb"
    linkdir=$(rl $1)
    logdir=$tbdir/$2
    ln -s $linkdir $logdir
    echo "linkdir: $linkdir"
    echo "logdir: $logdir"
  else
    echo "tbadd <exp_dir> <tb number>"
  fi
}

# -------------------------------------------------------------------
# Queue management
# -------------------------------------------------------------------

# Short aliases
full_queue='qstat -q "aml*.q@*" -f -u \*'
alias q='qstat'
alias qtop='qalter -p 1024'
alias qq=$full_queue # Display full queue
alias gq='qstat -q aml-gpu.q -f -u \*' # Display just the gpu queues
alias gqf='qstat -q aml-gpu.q -u \* -r -F gpu | egrep -v "jobname|Master|Binding|Hard|Soft|Requested|Granted"' # Display the gpu queues, including showing the preemption state of each job
alias cq='qstat -q "aml-cpu.q@gpu*" -f -u \*' # Display just the cpu queues
alias wq="watch qstat"
alias wqq="watch $full_queue"

# Queue functions
qlogin () {
  # Function to request gpu or cpu access
  # example:
  #    qlogin 2                request 2 gpus
  #    qlogin 1 cpu            request 1 cpu slot
  #    qlogin 1 aml-gpu.q@b5   request 1 gpu on b5
  if [ "$#" -eq 1 ]; then
    /usr/bin/qlogin -now n -pe smp $1 -q aml-gpu.q -l gpu=$1 -N D_$(whoami)
  elif [ "$#" -eq 2 ]; then
    if [ "$2" = "cpu" ]; then
      queue="aml-cpu.q"
    else
      queue="$2"
    fi
    /usr/bin/qlogin -now n -pe smp $1 -q $queue -l gpu=$1 -N D_$(whoami)
  else
    echo "Usage: qlogin <num_gpus>" >&2
    echo "Usage: qlogin <num_gpus> <queue>" >&2
    echo "Usage: qlogin <num_slots> cpu" >&2
  fi
}
qtail () {
  tail -f $(qlog $@)
}
qlast () {
  # Tail the last running job
  job_id=$(qstat | awk '$5=="r" {print $1}' | grep -E '[0-9]' | sort -r | head -n 1)
  if [ ! -z $job_id ]; then
    echo "qtail of most recent job ${job_id}"
    qtail ${job_id} $@ 
  else
    echo "no jobs found"
  fi
}
qless () {
  less $(qlog $@)
}
qcat () {
  cat $(qlog $@)
}
qlog () {
  # Get log path of job
  if [ "$#" -eq 1 ]; then
    echo $(qstat -j $1 | grep stdout_path_list | cut -d ":" -f4)
  elif [ "$#" -eq 2 ]; then
    log_path=$(qlog $1)
    base_dir=$(echo $log_path | rev | cut -d "/" -f3- | rev)
    filename=$(basename $log_path)
    if [ "$2" = "-p" ]; then
        echo ${base_dir}/log/${filename}
    else
        echo ${base_dir}/log/${filename%.log}${2}.log
    fi
  else
    echo "Usage: qlog <jobid>" >&2
    echo "Usage: qlog <array_jobid> <sub_jobid>" >&2
  fi
}
qdesc () {
  qstat | tail -n +3 | while read line; do
    job=$(echo $line | awk '{print $1}')
    if [[ ! $(qstat -j $job | grep "job-array tasks") ]]; then
      echo $job $(qlog $job)
    else
      qq_dir=$(qlog $job)
      job_status=$(echo $line | awk '{print $5}')
      if [ $job_status = 'r' ]; then
        sub_job=$(echo $line | awk '{print $10}')
        echo $job $sub_job $(qlog $job $sub_job)
      else
        echo $job $qq_dir $job_status
      fi
    fi
  done
}
qrecycle () {
    [ ! -z $SINGULARITY_CONTAINER ] && ssh localhost "qrecycle $@" || command qrecycle "$@";
}
qupdate () {
    [ ! -z $SINGULARITY_CONTAINER ] && ssh localhost "qupdate"|| command qupdate ;
}
makeallp() {
    qstat -u "*" | grep $1 | awk '{print $1}' | while read job; do qmakep $job; done
}

# Only way to get a gpu is via queue
if [ -z $CUDA_VISIBLE_DEVICES ]; then
  export CUDA_VISIBLE_DEVICES=
fi

# -------------------------------------------------------------------
# Cleaning processes
# -------------------------------------------------------------------

clean_vm () {
    ps -ef | grep zsh | awk '{print $2}' | xargs sudo kill
    ps -ef | grep vscode | awk '{print $2}' | xargs sudo kill
}

