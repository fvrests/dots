function nvim -w nvim -d "Change path when using ,<tool> binding"
    command nvim -c 'lcd %:p:h' $argv
end
