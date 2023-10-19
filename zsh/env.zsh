if [[ $0 == -*zsh* ]]; then
    # When sourced by Zsh
    ZSH_DOT_DIR=$(realpath "$(dirname "${(%):-%x}")")
elif [[ $0 == *bash* ]]; then
    # When sourced by Bash
    ZSH_DOT_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
else
    # When executed directly (not sourced)
    ZSH_DOT_DIR=$(realpath "$(dirname "$0")")
fi
export DOT_DIR=$(realpath "$ZSH_DOT_DIR"/../)

export OH_MY_ZSH=$HOME/.oh-my-zsh
export MY_BIN_LOC="$HOME/.local/dotbin"
export PRO_BASE="$HOME/git"

# These are an edited version of the default colors to better match the default mac colors
# Red executables, cyan dirs and purple symlinks
export LS_COLORS='rs=0:di=01;34:ln=01;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=32:st=37;44:ex=00;31:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

export LSCOLORS='Exfxcxdxbxegedabagacad'

# FZF options - might also affect fzf-lua extenstion in vim
export FZF_DEFAULT_OPTS='--color=16,bg:-1,bg+:#635B54,hl:4,hl+:4,fg:-1,fg+:-1,gutter:-1,pointer:-1,marker:-1,prompt:1 --height 60% --color border:-1 --border=rounded --no-scrollbar --no-separator --prompt="➤  " --pointer="➤ " --marker="➤ " --reverse'

export HISTSIZE=100000            # big big history
export HISTFILESIZE=100000        # big big history
export HISTTIMEFORMAT="%F %T "
export EDITOR=nvim                # of course
