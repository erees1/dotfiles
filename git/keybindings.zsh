# git add ci and push
function git_prepare() {
   if [ -n "$BUFFER" ]; then
	BUFFER="git add -u && git commit -m \"$BUFFER\" "
   fi

   if [ -z "$BUFFER" ]; then
	BUFFER="git add -u && git commit -v "
   fi
		
   zle accept-line
}
zle -N git_prepare
bindkey -r "\eg"
bindkey "\eg" git_prepare