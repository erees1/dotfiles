ZSH_DOT_DIR=$(dirname $(realpath ${(%):-%x}))/..

# Set array path to only have unique values
typeset -U path

source $ZSH_DOT_DIR/local/dir_colors.sh
source $ZSH_DOT_DIR/common/zshrc.sh
zstyle ':completion:*' list-colors $LS_COLORS

# When /etc/profile is run we make sure that the path is empty
# this prevents tmux from screwing with my path 
if [ -f /etc/profile ] ; then
    TMPPATH=$PATH
    source /etc/profile
    PATH=$TMPPATH
fi

# Need to remember to install miniconda to opt
conda_loc="${HOME}/opt/miniconda3"
if [[ "$PATH" != *"${conda_loc}"* ]]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!  - not any more
  __conda_setup=$("${conda_loc}/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "${conda_loc}/etc/profile.d/conda.sh" ]; then
          . "${conda_loc}/etc/profile.d/conda.sh"
      else
          export PATH="${conda_loc}/bin:$PATH"
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

