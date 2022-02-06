SHELL := /bin/sh

all:
	brew upgrade neovim --fetch-head
	npm i -g typescript typescript-language-server vscode-langservers-extracted @tailwindcss/language-server svelte-language-server @volar/server
	brew install shfmt stylua
	npm i -g @fsouza/prettierd
	brew install lua-language-server

neovim:
	brew upgrade neovim --fetch-head

servers: 
	npm i -g typescript typescript-language-server vscode-langservers-extracted @tailwindcss/language-server svelte-language-server @volar/server 
	brew install lua-language-server

formatters:
	brew install shfmt stylua
	npm i -g @fsouza/prettierd
