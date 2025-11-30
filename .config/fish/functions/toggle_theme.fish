# Set theme for macOS system, ghostty terminal, and fish shell
#
# @requires
# ghostty (https://github.com/ghostty-org/ghostty)
#
# @usage
# toggle_theme
# toggle_theme [system|light|dark]
function toggle_theme -a mode
    set dark_theme "Rose Pine"
    set light_theme "Rose Pine Dawn"
    set -q THEME

    if test "$mode" = light
        set -U THEME $light_theme
    else if test "$mode" = dark
        set -U THEME $dark_theme
    else if test "$THEME" = $dark_theme
        set -U THEME $light_theme
    else
        set -U THEME $dark_theme
    end

    # # todo: set in lazygit config
    # # info: https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md#custom-author-color
    # if test "$THEME" = "$dark_theme"
    #     sed -i "" -e \
    #         "s/    \"fvrests\": \"#d7827e\"/    \"fvrests\": \"#ebbcba\"/" \
    #         "$HOME/.config/lazygit/config.yml"
    #     sed -i "" -e \
    #         "s/    \"leaf\": \"#d7827e\"/    \"leaf\": \"#ebbcba\"/" \
    #         "$HOME/.config/lazygit/config.yml"
    #     sed -i "" -e \
    #         "s/    \"\*\": \"#907aa9\"/    \"*\": \"#c4a7e7\"/" \
    #         "$HOME/.config/lazygit/config.yml"
    # else
    #     sed -i "" -e \
    #         "s/    \"fvrests\": \"#ebbcba\"/    \"fvrests\": \"#d7827e\"/" \
    #         "$HOME/.config/lazygit/config.yml"
    #     sed -i "" -e \
    #         "s/    \"leaf\": \"#ebbcba\"/    \"leaf\": \"#d7827e\"/" \
    #         "$HOME/.config/lazygit/config.yml"
    #     sed -i "" -e \
    #         "s/    \"\*\": \"#c4a7e7\"/    \"*\": \"#907aa9\"/" \
    #         "$HOME/.config/lazygit/config.yml"
    # end

    # Manually change ghostty theme to local variant
    # Requires file `theme` in .config/ghostty 
    echo "theme = $THEME" >$HOME/.config/ghostty/theme
    osascript $HOME/.config/fish/functions/reload.scpt >/dev/null
end
