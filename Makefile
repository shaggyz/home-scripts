STOW=stow -t $(HOME) -v


help: ## Show this help
	@echo "Shaggyz dotfiles - make targets:\n"
	@grep '\#\#' Makefile | sed -e 's/\#\#/->/g'
	@echo ""


unix: ## Links unix-generic dotfiles
	$(STOW) bash
	$(STOW) nvim
	$(STOW) tmux
	$(STOW) wezterm
	$(STOW) vim


development: unix ## Links development-related dotfiles
	$(STOW) neovide
	$(STOW) intellij

linux: unix ## Links dotfiles only related to GNU/Linux
	$(STOW) dunst
	$(STOW) gtk2
	$(STOW) gtk3
	$(STOW) i3
	$(STOW) i3blocks
	$(STOW) mycli
	$(STOW) openbox
	$(STOW) polybar
	$(STOW) ranger
	$(STOW) ttrv
	$(STOW) urxvt
	$(STOW) x11

macos: unix ## Links macOS dotfiles
	echo "No dotfiles yet!"

windows: ## Some WSL dotfiles
	$(STOW) bash-wsl
