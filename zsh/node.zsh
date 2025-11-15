[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
export NVM_DIR="$HOME/.nvm"
export NVM_DIR=~/.nvm

# source $NVM_DIR/nvm.sh if it exists
if [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
fi