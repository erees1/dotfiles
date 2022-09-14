ZSH_DOT_DIR=$(dirname $(realpath ${(%):-%x}))/..
export LOC="local"

source $ZSH_DOT_DIR/local/dir_colors.sh
source $ZSH_DOT_DIR/common/zshrc.sh
zstyle ':completion:*' list-colors $LS_COLORS

# Local aliases
alias vm='ssh vm'
alias rl='greadlink -f'
alias cdm='cd ~/git/md-notes'
alias cdj='cd ~/git/jamming'
alias cdn='cd ~/git/jamming/notebooks'
alias jpl="jupyter lab"

function chpwd() {
 emulate -L zsh
 gls --color=auto --group-directories-first
}
alias ls="gls --color=auto --group-directories-first"

# Need to remember to install miniconda to opt
conda_loc="${HOME}/opt/miniconda3"
if command -v conda 2>/dev/null 2>&1; then
    echo 'found conda'
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
fi

# inserts shim for .rbenv if its not there already
if hash rbenv 2>/dev/null; then
  SUB='rbenv/shims'
  if [[ "$PATH" != *"$SUB"* ]]; then
    eval "$(rbenv init -)"
  fi
fi

