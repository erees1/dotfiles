# By default when you hold a key on mac it brings up the accents menu
# This means you can't hold vim keys in vscode so disable it
defaults write -g ApplePressAndHoldEnabled -bool false  

# Make key repeats faster
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 1

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's column view.
defaults write com.apple.Finder FXPreferredViewStyle clmv

# Make the menu items closer together
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 12
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 8

# Show the ~/Library folder
chflags nohidden ~/Library

echo "Set mac defaults, you will need to logout for them to take effect"
