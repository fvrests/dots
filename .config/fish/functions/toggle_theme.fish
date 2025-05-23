# Set theme for macOS system, ghostty terminal, and fish shell
#
# @requires
# kitty (https://github.com/kovidgoyal/kitty)
# OR
# ghostty (https://github.com/ghostty-org/ghostty)
#
# @usage
# toggle_theme
# toggle_theme [system|light|dark]
function toggle_theme -a mode

    set dark_theme rose-pine
    set light_theme rose-pine-dawn
    set -q THEME

    if test "$mode" = light
        set -u THEME $light_theme
    else if test "$mode" = dark
        set -u THEME $dark_theme
    else if test "$THEME" = $dark_theme
        set -u THEME $light_theme
    else
        set -u THEME $dark_theme
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

    # Manually change kitty theme to local variant
    # Requires `allow_remote_control yes` in your kitty.conf
    sed -i "" -e \
        "s/include themes\/.*\.conf/include themes\/$THEME.conf/" \
        "$HOME/.config/kitty/kitty.conf"

    if test "$TERM" = xterm-kitty
        kitty @ set-colors --all --configured "~/.config/kitty/themes/$THEME.conf"
        # Use kitten to set theme
        # Syntax may differ, eg. rose-pine becomes Rosé Pine
        # kitty +kitten themes --reload-in=all "$THEME"
    end

    # Manually change ghostty theme to local variant
    # Requires file `theme` in .config/ghostty 
    echo "theme = $THEME" >$HOME/.config/ghostty/theme
    osascript $HOME/.config/fish/functions/reload.scpt >/dev/null
end
