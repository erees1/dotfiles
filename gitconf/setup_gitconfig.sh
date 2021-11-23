# $LOC variable is one of local/remote
base_config=$(cat <<-END
[include]
    path = $DOT_DIR/gitconf/gitconfig
    path = $DOT_DIR/gitconf/gitconfig.$LOC
END
)
echo "$base_config" > $HOME/.gitconfig 
