#!/bin/zsh

# extra aliases
alias ls='ls -hF --color' # add colors for filetype recognition

# Make color of directoroies purple not dark blue
LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LS_COLORS

# -------------------------------------------------------------------
# speechmatics
# -------------------------------------------------------------------

# jupyter lab
alias jpl="jupyter lab --no-browser --ip $(/bin/hostname)"
alias cjpl="cuda_wrapper 1 jupyter lab --no-browswer --ip $(/bin/hostname)"
# virtual envs
alias veh="source /cantab/dev/inbetweeners/hydra/venv_stable/bin/activate"
alias ve="source ~/venv/bin/activate"

# make file
alias m='make'
alias mc="make check"
alias mf="make format"
alias mtest="make test"
alias mft="make functest"
alias mut="make unittest"

# tensorboard
alias tbr='source $HOME/venvs/venv_tb/bin/activate && tensorboard --host=$(hostname) --logdir=.'
alias tbkill="ps aux | grep tensorboard | grep edwardr | awk '{print \$2}' | xargs kill"

tblink () {
  if [ "$#" -eq 0 ]; then
    logdir=$(pwd)
  else
  # setup tensorboard directory
    tbdir="$HOME/tb"
    if [ -d "$tbdir" ]; then
      
      last=$(ls -v $tbdir | tail -1)
      new=$((last+1))
      logdir="$tbdir/$new"
    else
      logdir="$tbdir/0"
    fi
    mkdir -p $logdir
    # softlink into tensorboard directory
    for linkdir in "$@"; do
      linkdir=$(rl $linkdir)
      echo "linkdir: $linkdir"
      ln -s $linkdir $logdir
    done
  fi
  echo "logdir: $logdir"
  tensorboard --host=$(hostname) --logdir=$logdir
}

# quick navigation
alias cda="cd ~/git/aladdin"
alias cdh="cd ~/git/hydra"
alias dev='cd /cantab/dev/inbetweeners/hydra'
alias exp='cd /cantab/dev/inbetweeners/hydra/exp'
alias data='cd /cantab/data'
exp0 () {
  cd /cantab/exp0/inbetweeners/hydra
  ls -tcrd edwardr*
}

# gpu
alias qq='qstat -f -u "*"'
alias q='qstat'
alias qc='source ~/venv_dashboard/bin/activate && ~/git/dotfiles/scripts/qstat.py'
alias qcpu='qstat -f -u "*" -q cpu.q'
alias qgpu='qstat -f -u "*" -q gpu.q'
alias qtop='qalter -p 1024'

# New ones
alias qq='qstat -q "aml*.q@*" -f -u \*' # Display full queue
alias gq='qstat -q aml-gpu.q -f -u \*' # Display just the gpu queues
alias gqf='qstat -q aml-gpu.q -u \* -r -F gpu | egrep -v "jobname|Master|Binding|Hard|Soft|Requested|Granted"' # Display the gpu queues, including showing the preemption state of each job
alias cq='qstat -q "aml-cpu.q@gpu*" -f -u \*' # Display just the cpu queues

qlogin () {
  echo "$#"
  if [ "$#" -eq 1 ]; then
    /usr/bin/qlogin -now n -pe smp $1 -q aml-gpu.q -l gpu=$1 -pty y -N D_edwardr
  elif [ "$#" -eq 2 ]; then
    /usr/bin/qlogin -now n -pe smp $1 -q $2 -l gpu=$1 -pty y -N D_johnh
  else
    echo "Usage: qlogin <num_gpus>" >&2
    echo "Usage: qlogin <num_gpus> <queue>" >&2
  fi
}
alias gpu980='qrsh -q gpu.q@@980 -pty no -now n'
alias titanx='qrsh -q gpu.q@@titanx -pty no -now n'


qrl () {
  if [ "$#" -eq 1 ]; then
    qrsh -q gpu.q@"$1".cantabresearch.com -pty no -now n
  else
    qrsh -q gpu.q -pty no -now n
  fi
}

alias nv='nvidia-smi'
alias cuda0='export CUDA_VISIBLE_DEVICES=0'
alias cuda1='export CUDA_VISIBLE_DEVICES=1'
cuda () {
  if [ "$#" -eq 1 ]; then
    export CUDA_VISIBLE_DEVICES=$1
  else
    echo "Usage: cuda <slot>" >&2
  fi
}

qtail () {
  tail -f $(qlog $@)
}
qless () {
  less $(qlog $@)
}
qcat () {
  cat $(qlog $@)
}
qlog () {
  if [ "$#" -eq 1 ]; then
    echo $(qstat -j $1 | grep stdout_path_list | cut -d ":" -f4) 
  elif [ "$#" -eq 2 ]; then
    qq_dir=$(qlog $1)
    echo $(ls ${qq_dir}/*o${1}.${2})
  else
    echo "Usage: q<command> <jobid>" >&2
    echo "Usage: q<command> <array_jobid> <sub_jobid>" >&2
  fi
}
qdesc () {
  qstat | tail -n +3 | while read line; do
    job=$(echo $line | awk '{print $1}')
    if [ -z "$(qstat -j $job | grep "job-array tasks")" ]; then
      echo $job $(qlog $job)
    else
      qq_dir=$(qlog $job)
      if [ $(echo $line | awk '{print $5}') = 'r' ]; then
        sub_job=$(echo $line | awk '{print $10}')
        qq_dir=$(qlog $job)
        log_file=$(find ${qq_dir} -name "*o${job}.${sub_job}")
        echo $job $sub_job $(grep -o -m 1 -E "expdir=[^ ]* "  $log_file | cut -d "=" -f2)
      else
        echo $job $qq_dir "qw"
      fi
    fi
  done
}

# docker
alias dsts='docker stack services demo'
alias dstr='docker stack rm demo'
alias dstd='docker stack deploy -c demo.yml demo'
alias dstp='docker stack ps demo'
alias ds='docker stats'
alias di='docker images'
alias dl='docker logs'
# stop and remove all containers
alias harpoon='(docker stop $(docker ps -a -q); docker rm -f $(docker ps -a -q))'
# remove all untagged images
alias flense='docker rmi -f $(docker images | grep "^<none>" | awk "{print $3}")'
function jonah() { docker exec -it $@ /bin/bash ;}
