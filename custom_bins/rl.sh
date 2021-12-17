# readlink -f but copy the result to the clipboard
path=$(readlink -f $@)
echo $path
echo $path | yk
