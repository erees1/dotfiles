
# When /etc/profile is run we make sure that the path is empty
# this prevents tmux from screwing with my path 
if [ -f /etc/profile ] ; then
    TMPPATH=$PATH
    source /etc/profile
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/edwardrees/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/edwardrees/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/edwardrees/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/edwardrees/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# inserts shim for .rbenv
eval "$(rbenv init -)"
