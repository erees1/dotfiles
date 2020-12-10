USAGE="Usage: ./install.sh or ./install.sh --noroot"

if [ $# -eq 0 ]
  then
    echo "Error: No flags provided"
    echo $USAGE
    exit 1
fi


root_access=true

PARAMS=""
while (( "$#" )); do
  case "$1" in
    -h|--help)
      echo $USAGE
      exit
      ;;
    --noroot)
      root_access=false
      shift
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

if [ "tmux" == $PARAMS ]; then
    echo here
fi