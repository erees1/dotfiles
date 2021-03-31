
# Set array path to only have unique values
typeset -U path

# When /etc/profile is run we make sure that the path is empty
# this prevents tmux from screwing with my path 
if [ -f /etc/profile ] ; then
    TMPPATH=$PATH
    source /etc/profile
    PATH=$TMPPATH
fi

if [[ "$PATH" != *"miniconda3"* ]]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  conda_loc="${HOME}/.local"
  __conda_setup=$("${conda_loc}/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "${conda_loc}/miniconda3/etc/profile.d/conda.sh" ]; then
          . "${conda_loc}/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="${conda_loc}/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
fi

# add pyenv if pyenv isntalled
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# inserts shim for .rbenv if its not there already
if hash rbenv 2>/dev/null; then 
  SUB='rbenv/shims'
  if [[ "$PATH" != *"$SUB"* ]]; then
    eval "$(rbenv init -)"
  fi
fi

# add ./local/bin to path
p="${HOME}/.local/bin"
if [[ "$PATH" != *"$p"* ]]; then
  export PATH="$p:$PATH"
fi
