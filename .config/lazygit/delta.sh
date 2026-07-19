#!/usr/bin/env bash

# todo: adapt to user-set dark/light theme - interact with fish settings?
# if defaults read -g AppleInterfaceStyle &>/dev/null; then
# dark
	# exec delta --dark --line-numbers-minus-style="#eb6f92" --minus-emph-style="#eb6f92 reverse" --minus-style="#eb6f92 #2c212e" --line-numbers-plus-style="#31748f " --plus-emph-style="#31748f reverse" --plus-style="#31748f #1c202e" "$@"
# else
#light
	exec delta --light --line-numbers-minus-style="#b4637a" --minus-emph-style="#b4637a reverse" --minus-style="#b4637a #f1e5e2" --line-numbers-plus-style="#286983" --plus-emph-style="#286983 reverse" --plus-style="#286983 #e5e6e2" "$@"
# fi
