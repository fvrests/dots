#!/usr/bin/env bash

clear

echo "dots"

if ! [ -f ~/.ssh/id_ed25519 ]; then
	echo "- no ssh credentials found. initializing ssh files at ~/.ssh"
	mkdir ~/.ssh
	chmod 700 ~/.ssh
	touch ~/.ssh/id_ed25519.pub
	chmod 644 ~/.ssh/id_ed25519.pub
	touch ~/.ssh/id_ed25519
	chmod 600 ~/.ssh/id_ed25519
	read -p "- copy public key and press any key to open ~/.ssh/id_ed25519.pub"
	$EDITOR ~/.ssh/id_ed25519.pub 
	read -p "- copy private key and press any key to open ~/.ssh/id_ed25519"
	$EDITOR ~/.ssh/id_ed25519
	read -p "- press any key to use ssh origin for dotfiles"
	git --git-dir=$HOME/dots.git/ --work-tree=$HOME remote set-url origin git@github.com:fvrests/dots.git
fi

if ! [ $(which brew) ]; then
	echo "- installing homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	export PATH=/opt/homebrew/bin:$PATH
fi

brew upgrade
brew bundle --file="$HOME/brewfile"
brew cleanup

if [ $(which fish) ]; then
	echo "- setting default shell: fish"
	echo $(which fish) | sudo tee -a /etc/shells
	chsh -s $(which fish)
fi

if [ $(uname) == "Darwin" ]; then
	# copy sf mono from terminal.app
	cp -r /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/. /Library/Fonts/

	# dock
	defaults write com.apple.dock autohide -bool true      # autohide
	defaults write com.apple.dock persistent-apps -array   # remove all docked apps
	defaults write com.apple.dock show-recents -bool false # disable recent apps
	defaults write com.apple.dock static-only -bool true   # show only active apps
	defaults write com.apple.dock mru-spaces -bool false   # disable mru (most recent use) spaces

	# keyboard
	defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false             # disable auto correct
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false     # disable auto capitalise
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false   # disable smart dash
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false  # disable smart quote
	defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false # disable period on double space
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false             # enable key repeat in all apps
	defaults write NSGlobalDomain InitialKeyRepeat -int 15                         # set shorter delay before key repeat
	defaults write NSGlobalDomain KeyRepeat -int 2                                 # enable faster key repeat

	# menubar
	defaults write NSGlobalDomain _HIHideMenuBar -bool true     # autohide
	defaults write com.apple.Siri StatusMenuVisible -bool false # hide siri

	# screencapture
	defaults write com.apple.screencapture location ~/Downloads      # set default save location
	defaults write com.apple.screencapture disable-shadow -bool true # disable shadow

	# trackpad
	defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true                  # tap to click (trackpad)
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # tap to click (bluetooth trackpad)
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1         # tap to click (mouse, current host)
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1                      # tap to click (mouse)
	defaults write -g com.apple.trackpad.scaling -int 3                                   # increase tracking speed

	# finder
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # disable file extension change warning
	defaults write com.apple.finder WarnOnEmptyTrash -bool false               # disable empty trash warning
fi

echo "done; suggested next steps:"
echo "- sign in to icloud"
echo "- schedule night shift"
echo "- map caps lock to escape"
echo "- enable full disk access for terminal.app"
echo "- show develop in safari menu"
echo "- to set accent color, go to .local/bin folder and run sh macos-accent.sh"
echo "- reboot for all changes to take effect"
