# Set theme for macOS system, kitty terminal, and fish shell
#
# @requires
# kitty (https://github.com/kovidgoyal/kitty)
#
# @usage
# toggle_theme
# toggle_theme [system|light|dark]
function toggle_theme -a mode
    function _use_terminal_colors
        printf "* Matching terminal colors.\n"

        # Syntax highlighting variables
        # https://fishshell.com/docs/current/interactive.html#syntax-highlighting-variables
        set -U fish_color_normal normal
        set -U fish_color_command magenta
        set -U fish_color_keyword blue
        set -U fish_color_quote yellow
        set -U fish_color_redirection green
        set -U fish_color_end brblack
        set -U fish_color_error red
        set -U fish_color_param cyan
        set -U fish_color_comment brblack
        set -U fish_color_selection --reverse
        set -U fish_color_operator normal
        set -U fish_color_escape green
        set -U fish_color_autosuggestion brblack
        set -U fish_color_cwd cyan
        set -U fish_color_user yellow
        set -U fish_color_host blue
        set -U fish_color_host_remote magenta
        set -U fish_color_cancel normal
        set -U fish_color_search_match --background=black
        set -U fish_color_valid_path

        # Pager color variables
        # https://fishshell.com/docs/current/interactive.html#pager-color-variables
        set -U fish_pager_color_progress cyan
        set -U fish_pager_color_background
        set -U fish_pager_color_prefix blue
        set -U fish_pager_color_completion brblack
        set -U fish_pager_color_description brblack
        set -U fish_pager_color_secondary_background
        set -U fish_pager_color_secondary_prefix
        set -U fish_pager_color_secondary_completion
        set -U fish_pager_color_secondary_description
        set -U fish_pager_color_selected_background
        set -U fish_pager_color_selected_prefix blue
        set -U fish_pager_color_selected_completion white
        set -U fish_pager_color_selected_description white

        # Because this function should only run once, erase after use
        functions -e _use_terminal_colors
    end

    set dark_theme rose-pine
    set light_theme rose-pine-dawn
    set -q THEME; or _use_terminal_colors
    set -q THEME; or set -U THEME $dark_theme

    if test "$mode" = light
        set -u THEME $light_theme
    else if test "$mode" = dark
        set -u THEME $dark_theme
    else if test "$THEME" = $dark_theme
        set -u THEME $light_theme
    else
        set -u THEME $dark_theme
    end

    if test "$THEME" = "$dark_theme"
        sed -i "" -e \
            "s/    \"fvrests\": \"#d7827e\"/    \"fvrests\": \"#ebbcba\"/" \
            "$HOME/.config/lazygit/config.yml"
        sed -i "" -e \
            "s/    \"leaf\": \"#d7827e\"/    \"leaf\": \"#ebbcba\"/" \
            "$HOME/.config/lazygit/config.yml"
        sed -i "" -e \
            "s/    \"\*\": \"#907aa9\"/    \"*\": \"#c4a7e7\"/" \
            "$HOME/.config/lazygit/config.yml"
    else
        sed -i "" -e \
            "s/    \"fvrests\": \"#ebbcba\"/    \"fvrests\": \"#d7827e\"/" \
            "$HOME/.config/lazygit/config.yml"
        sed -i "" -e \
            "s/    \"leaf\": \"#ebbcba\"/    \"leaf\": \"#d7827e\"/" \
            "$HOME/.config/lazygit/config.yml"
        sed -i "" -e \
            "s/    \"\*\": \"#c4a7e7\"/    \"*\": \"#907aa9\"/" \
            "$HOME/.config/lazygit/config.yml"
    end

    if type -q kitty
        # Manually change kitty theme to local variant
        # Requires `allow_remote_control yes` in your kitty.conf
        kitty @ set-colors --all --configured "~/.config/kitty/themes/$THEME.conf"
        sed -i "" -e \
            "s/include themes\/.*\.conf/include themes\/$THEME.conf/" \
            "$HOME/.config/kitty/kitty.conf"

        # Use kitten to set theme
        # Syntax may differ, eg. rose-pine becomes Rosé Pine
        # kitty +kitten themes --reload-in=all "$THEME"
    end
end
