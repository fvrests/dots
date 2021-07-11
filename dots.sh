#!/usr/bin/env bash

app=~/.config/fvrests-dots
repo=https://github.com/fvrests/dots

pink() {
	echo "\033[0;35m$1\033[0m"
}

purple() {
	echo "\033[0;34m$1\033[0m"
}

gray() {
	echo "\033[0;90m$1\033[0m"
}

item() {
	echo "\033[0;90m✨  $1\033[0m"
}

put_header() {
	clear
	echo
	echo "✨ 🌛 🌞 dots 🌞 🌜 ✨"
	echo
	purple "a mystical quest to set up your dev machine"
	pink $repo
	echo
}

while getopts u:e:s:h option; do
	case "${option}" in
	u) git_user=${OPTARG} ;;
	e) git_email=${OPTARG} ;;
	s) shell=${OPTARG} ;;
	h)
		put_header
		pink "🧝‍♀️ Welcome, traveler. Let me be of some assistance. This script was written to guide you through the journey of setting up your machine after cleansing it of the burden of the past."
		echo
		gray "These are the words you will speak to start your quest:"
		echo
		echo "  sh $0 [-u USER] [-e EMAIL]"
		echo
		gray "Here is a list of spells that will guide you:"
		echo
		echo "  -u [user]           set your user for global git config"
		echo "  -e [email]          set your email for global git config and ssh keys"
		echo "  -s [shell]          set your default shell"
		echo "  -h                  just type this if you get lost again, OK?"
		echo
		echo "Other travelers on this quest have tried:"
		echo
		echo "  $ sh $0 -u wizard -e wizard@firemail.com"
		echo "  $ sh $0 -s fish"
		echo
		gray "And if you require further training,"
		gray "just follow these directions:"
		echo
		echo "  $repo"
		echo
		pink "🧝‍♀️ Run along now!"
		pink "   Be careful not to disturb the creatures of the forest on your way,"
		pink "   for some of them may not be especially friendly!"
		exit 2
		;;
	esac
done

init() {
	put_header
	pink "🧝‍♀ Ah, so you wanted to start over? Glad you came to me. Let's get you set up with Homebrew to start your journey."

	if ! type brew &>/dev/null; then
		item "https://brew.sh"

		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	else
		item "Oh, it seems you already have it! Let's go on then."
	fi

	echo

	get_command_line_tools
	get_repo

	echo "🧝‍♀ Now we're going to update the Packages of Brew. This may take many moons, so be patient, little mage."
	item "Using $app/brewfile"

	brew upgrade &>/dev/null
	brew bundle --file="$app/brewfile" &>/dev/null
	brew cleanup &>/dev/null

	# if ! [[ -z ${git_email} ]]; then
	# mas signin $git_email
	# fi

	item "Sweeping up..."
	echo

	config_git
	config_ssh
	config_apps
	config_prefs
	end_journey
}

get_command_line_tools() {
	xcode-select --install &>/dev/null

	sleep 5

	if ! [ $(xcode-select --print-path) ]; then
		put_header

		echo "🧝‍♀ Looks like we should wait for your command line tools to finish installing..."

		get_command_line_tools
	fi
}

get_repo() {
	echo "🧝‍♀ Fetching the remote repo from far away..."

	if ! [ -e $app ]; then
		item "Cloning to $app now"

		mkdir -p $app
		git clone $repo $app &>/dev/null
	else
		item "You already have $app? My, they're sending you mages out prepared these days. Let's go on then."
	fi

	echo
}

config_git() {
	echo "🧝‍♀ You've progressed far, young one. I believe you're ready to prepare your global git."

	if ! [ -f ~/.gitconfig ]; then
		item "Writing your user and password into git lore..."
		if ! [[ -z ${git_user} ]]; then
			git config --global user.name "$git_user"
		fi

		if ! [[ -z ${git_email} ]]; then
			git config --global user.email "$git_email"
		fi

	else
		item "Git already knows you, traveler. Let's continue."
	fi

	echo ".DS_Store" >~/.gitignore
	git config --global core.excludesfile ~/.gitignore
	git config --global pull.rebase false
	git config --global init.defaultBranch "main"

	echo
}

config_ssh() {
	echo "🧝‍♀ Next we'll need to forge your ssh keys..."

	if ! [ -f ~/.ssh/id_ed25519 ]; then
		if ! [[ -z ${git_email} ]]; then
			item "Generating key with git email"
			ssh-keygen -t ed25519 -C $git_email -f ~/.ssh/id_ed25519 -q -N ""
		else
			item "Generating key with computer hostname"
			ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -N ""
		fi

		pbcopy <~/.ssh/id_ed25519.pub

		item "Storing your public key in the clipboard."
		item "Saved to ~/.ssh/id_ed25519.pub"
	else
		item "Since you already have them from your last adventure, I'll continue."
	fi

	echo
}

config_apps() {
	echo "🧝‍♀ Now, let me see your travelers' log. We'll update your app preferences so you don't leave anything behind."

	if [ $(which zsh) ]; then
		item "Copying Zsh settings"
		cp -r $app/.zshrc ~/
	fi

	if ! [ -z ${shell} ]; then
		if [ $(which $shell) ]; then
			echo "Setting default shell"
			item "$shell"
			echo $(which $shell) | sudo tee -a /etc/shells
			chsh -s $(which $shell)
		fi
	fi

	if [ $(which fish) ]; then
		item "Copying Fish settings"
		mkdir -p ~/.config/fish
		cp -r $app/config.fish ~/.config/fish/config.fish
		cp -r $app/fishfile ~/.config/fish/fishfile
		cp -r $app/fish_variables ~/.config/fish/fish_variables
	fi

	item "Copying iTerm settings"
	cp -r $app/com.googlecode.iterm2.plist ~/Library/Preferences/

	if [ $(which code-insiders) ]; then
		item "Copying VSCode Insiders settings"
		mkdir -p ~/Library/Application\ Support/Code\ -\ Insiders/User
		cp $app/vscode.json ~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json

		code-insiders --install-extension esbenp.prettier-vscode &>/dev/null
		code-insiders --install-extension vscodevim.vim &>/dev/null
		# code-insiders --install-extension octref.vetur &>/dev/null;
		code-insiders --install-extension johnsoncodehk.volar &>/dev/null
		code-insiders --install-extension bradlc.vscode-tailwindcss &>/dev/null
		code-insiders --install-extension mvllow.rose-pine &>/dev/null
		code-insiders --install-extension arcticicestudio.nord-visual-studio-code &>/dev/null
		code-insiders --install-extension wayou.vscode-todo-highlight &>/dev/null

	fi

	echo
}

config_prefs() {
	echo "🧝‍♀ Finally, we will bring your preferences before the System to write them into magical law."

	item "Copying SF Mono to Font Book"
	cp -r /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/. /Library/Fonts/

	item "Modifying preferences"

	# Global: change accent color to pink
	defaults write -globalDomain AppleAccentColor -int 6
	# Global: change highlight color to purple
	defaults write -globalDomain AppleHighlightColor -string "0.968627 0.831373 1.000000 Purple"
	# Dock: enable autohide
	defaults write com.apple.dock autohide -bool true
	# Dock: hide recent apps
	defaults write com.apple.dock show-recents -bool false
	# Dock: show only active apps
	defaults write com.apple.dock static-only -bool true

	# Keyboard: disable auto correct
	defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
	# Keyboard: disable auto capitalize
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
	# Keyboard: disable smart dashes
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	# Keyboard: disable smart quotes
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	# Keyboard: enable key repeat
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
	# Keyboard: faster key repeat
	defaults write NSGlobalDomain KeyRepeat -int 2
	# Keyboard: shorter delay before key repeat
	defaults write NSGlobalDomain InitialKeyRepeat -int 10

	# Trackpad: enable tap to click (this user and login screen)
	defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	# Trackpad: increase tracking speed
	defaults write -g com.apple.trackpad.scaling 3

	# Finder: disable warning on file extension change
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	# Finder: disable warning when emptying trash
	defaults write com.apple.finder WarnOnEmptyTrash -bool false

	# Menubar: enable autohide
	defaults write NSGlobalDomain _HIHideMenuBar -bool true

	echo
}

end_journey() {
	echo
	pink "🧝‍♀️ And that's the end! Our journey is complete. Please don't hesitate to find me again should you require my assistance."
	echo
	echo
	purple "Thank you for using"
	echo "✨ 🌛 🌞 dots 🌞 🌜 ✨"
	echo
	purple "Full documentation for this script can be found here:"
	pink $repo
	echo
}

if [ $(uname) == "Darwin" ]; then
	init
else
	put_header

	echo "Alas, you're in the wrong forest! Your OS, $(uname), is unsupported."
	exit 1
fi
