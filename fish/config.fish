set PATH /opt/homebrew/bin $PATH
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
set fish_greeting
set pure_symbol_prompt ▲ 
alias ci="code-insiders"
