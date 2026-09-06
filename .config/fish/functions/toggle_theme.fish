# Set theme for macOS system, ghostty terminal, and fish shell
#
# @requires
# ghostty (https://github.com/ghostty-org/ghostty)
#
# @usage
# toggle_theme
# toggle_theme [system|light|dark]
function toggle_theme -a mode
    osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode"
end
