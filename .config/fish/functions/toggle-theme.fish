function toggle-theme -d "toggle kitty theme (which will indirectly update fish)"
    use-terminal-colors

    set current_theme (awk '$1=="include" {print $2}' "$HOME/.config/kitty/kitty.conf")
    set new_theme "rose-pine.conf"

    if [ "$current_theme" = "rose-pine.conf" ]
        set new_theme 'rose-pine-moon.conf'
        sed -i '' -e "s/#ebbcba/#ea9a97/" "$HOME/.config/lazygit/config.yml"
    else if [ "$current_theme" = "rose-pine-moon.conf" ]
        set new_theme "rose-pine-dawn.conf"
        sed -i '' -e "s/#ea9a97/#d7827e/" "$HOME/.config/lazygit/config.yml"
        sed -i '' -e "s/#c4a7e7/#907aa9/" "$HOME/.config/lazygit/config.yml"
    else
        set new_theme "rose-pine.conf"
        sed -i '' -e "s/#d7827e/#ebbcba/" "$HOME/.config/lazygit/config.yml"
        sed -i '' -e "s/#907aa9/#c4a7e7/" "$HOME/.config/lazygit/config.yml"
    end

    # Set theme for active sessions. Requires `allow_remote_control yes`
    kitty @ set-colors --all --configured "~/.config/kitty/$new_theme"

    # Update config for persistence
    sed -i '' -e "s/include.*/include $new_theme/" "$HOME/.config/kitty/kitty.conf"
end

function use-terminal-colors
    # syntax highlighting variables
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

    # pager color variables
    # https://fishshell.com/docs/current/interactive.html#pager-color-variables
    set -U fish_pager_color_progress cyan
    set -U fish_pager_color_background
    set -U fish_pager_color_prefix blue
    set -U fish_pager_color_completion normal
    set -U fish_pager_color_description normal
    set -U fish_pager_color_selected_background --reverse
    set -U fish_pager_color_selected_prefix
    set -U fish_pager_color_selected_completion
    set -U fish_pager_color_selected_description
    set -U fish_pager_color_secondary_background
    set -U fish_pager_color_secondary_prefix blue
    set -U fish_pager_color_secondary_completion normal
    set -U fish_pager_color_secondary_description normal
end
