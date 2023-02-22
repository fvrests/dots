set -q XDG_CACHE_HOME; or set -xg XDG_CACHE_HOME $HOME/.cache
set -q XDG_CONFIG_HOME; or set -xg XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -xg XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -xg XDG_STATE_HOME $HOME/.local/state

set -gx EDITOR nvim
set -gx LSCOLORS ExGxBxDxCxEgEdxbxgxcxd
set -gx GOPATH $XDG_DATA_HOME/go

fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.local/bin

if status is-interactive
    set fish_greeting '🐟'

    function fish_title
        # get current directory name based on end of path
        set current_dir (string split -- / $PWD)[-1]
        # get current process name, e.g. "nvim" or "pnpm dev"
        set current_process $argv[1]

        set message ''
        if set -q $current_process
            set message "- $current_process"
        end

        switch $current_process
            case '* dev'
                echo $current_dir ‣
            case nvim 'nvim *'
                echo $current_dir •
            case '*'
                echo $current_dir $message
        end
    end

    function fish_prompt
        set -g fish_prompt_pwd_dir_length 0
        printf '%s%s> ' (prompt_pwd) (set_color yellow; fish_git_prompt; set_color normal)
    end
end

alias rm trash

abbr --add lg lazygit
abbr --add p pnpm
abbr --add n nvim


abbr --add .git "git --git-dir=$HOME/dots.git --work-tree=$HOME"
abbr --add .list "git --git-dir=$HOME/dots.git --work-tree=$HOME ls-files --other --no-empty-directory --exclude-standard $HOME/.config/*"
abbr --add .lg "lazygit --git-dir=$HOME/dots.git --work-tree=$HOME"

abbr --add ,kitty "$EDITOR ~/.config/kitty/kitty.conf +'lcd %:p:h'"
abbr --add ,fish "$EDITOR ~/.config/fish/config.fish +'lcd %:p:h'"
abbr --add ,nvim "$EDITOR ~/.config/nvim/init.lua +'lcd %:p:h'"
abbr --add ,lg "$EDITOR ~/.config/lazygit/config.yml +'lcd %:p:h'"
abbr --add ,lf "$EDITOR ~/.config/lf/lfrc +'lcd %:p:h'"
