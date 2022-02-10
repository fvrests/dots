set -q XDG_CONFIG_HOME; or set -xg XDG_CONFIG_HOME $HOME/.config

set -gx EDITOR nvim
set -gx LS_COLORS true

fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin

if status is-interactive
    set fish_greeting '🐟'
    function fish_prompt
        set -g fish_prompt_pwd_dir_length 0
        printf '%s%s> ' (prompt_pwd) (set_color yellow; fish_git_prompt; set_color normal)
    end
end

abbr --add ci code-insiders
abbr --add lg lazygit
abbr --add p pnpm
abbr --add n nvim
abbr --add px pnpx
abbr --add .git "git --git-dir=$HOME/dots.git --work-tree=$HOME"
abbr --add .list "git --git-dir=$HOME/dots.git --work-tree=$HOME ls-files --other --no-empty-directory --exclude-standard $HOME/.config/*"
abbr --add .lg "lazygit --git-dir=$HOME/dots.git --work-tree=$HOME"
abbr --add ,kitty "$EDITOR ~/.config/kitty/kitty.conf +'lcd %:p:h'"
abbr --add ,nvim "$EDITOR ~/.config/nvim/init.lua +'lcd %:p:h'"
abbr --add ,fish "$EDITOR ~/.config/fish/config.fish +'lcd %:p:h'"
abbr --add ,helix "$EDITOR ~/.config/helix/config.toml +'lcd %:p:h'"
abbr --add ,lg "$EDITOR ~/.config/lazygit/config.yml +'lcd %:p:h'"

bind \e\[108\;9u toggle-theme # `super+l`
