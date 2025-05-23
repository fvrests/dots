set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx EDITOR nvim
set -gx LSCOLORS ExGxBxDxCxEgEdxbxgxcxd # bold folders in ls
set -gx GOPATH $XDG_DATA_HOME/go

fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $GOPATH/bin
fish_add_path $HOME/.local/bin

if status is-interactive
    set fish_greeting 'Ti amo mi amore 󰊠 '

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
            case '*dev'
                echo ‣ $current_dir
            case nvim 'nvim *'
                echo ⋯ $current_dir
            case '*'
                echo $current_dir $message
        end
    end

    function fish_prompt
        set -g fish_prompt_pwd_dir_length 0
        set -gx __fix_git_prompt_showupstream informative
        set -gx __fish_git_prompt_showstashstate true
        set -gx __fish_git_prompt_char_stateseparator '|'
        set -gx __fish_git_prompt_char_cleanslate '  '
        printf '%s%s> ' (prompt_pwd) (set_color yellow; fish_git_prompt; set_color normal)
    end
end

abbr --add n nvim
abbr --add p pnpm
abbr --add lg lazygit

# treat .git on expand as git prefix (e.g. .git add /dir/filename)
abbr --add .git "git --git-dir=$HOME/dots.git --work-tree=$HOME"
abbr --add .list "git --git-dir=$HOME/dots.git --work-tree=$HOME ls-files --other --no-empty-directory --exclude-standard $HOME/.config/*"
abbr --add .lg "lazygit --git-dir=$HOME/dots.git --work-tree=$HOME"

abbr --add ,kitty "$EDITOR ~/.config/kitty/kitty.conf +'lcd %:p:h'"
abbr --add ,ghostty "$EDITOR ~/.config/ghostty/config +'lcd %:p:h'"
abbr --add ,fish "$EDITOR ~/.config/fish/config.fish +'lcd %:p:h'"
abbr --add ,nvim "$EDITOR ~/.config/nvim/init.lua +'lcd %:p:h'"
abbr --add ,lg "$EDITOR ~/.config/lazygit/config.yml +'lcd %:p:h'"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# rbenv
# https://jeremywsherman.com/blog/2015/07/28/using-rbenv-with-fish/
fish_add_path "$HOME/.rbenv/shims"
rbenv rehash
function rbenv
    set -l command $argv[1]
    if test (count $argv) -gt 1
        set argv $argv[2..-1]
    end

    switch "$command"
        case rehash shell
            eval (rbenv "sh-$command" $argv)
        case '*'
            command rbenv "$command" $argv
    end
end

# libpq
fish_add_path /opt/homebrew/opt/libpq/bin
