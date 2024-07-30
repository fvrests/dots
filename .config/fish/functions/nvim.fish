function nvim -w nvim -d "Start Neovim with adaptive background"
    if test "$THEME" = rose-pine
        command nvim -c 'lcd %:p:h' -c 'set background=dark' $argv
    else
        command nvim -c 'lcd %:p:h' -c 'set background=light' $argv
    end
end
