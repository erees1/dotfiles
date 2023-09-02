# By default when you hold a key on mac it brings up the accents menu
# This means you can't hold vim keys in vscode so disable it
defaults write -g ApplePressAndHoldEnabled -bool false  

# Make key repeats faster
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 1

echo "Set mac defaults, you will need to logout for them to take effect"