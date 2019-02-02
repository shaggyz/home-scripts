help:
	@echo "Usage: make <directive>"
	@echo "\nDirectives:\n"
	@grep \#\# Makefile | grep -v Makefile | sed 's/: \#\#/ \->/g'

update: ## Update the configuration in the current system.
	@echo "Updating local configuration from github..."
	git pull origin master
ifneq (,$(wildcard ~/.vimrc))
	make vim
endif
ifneq (,$(wildcard ~/.tmux.conf))
	make tmux
endif
ifneq (,$(wildcard ~/.Xresources))
	make x11
endif
ifneq (,$(wildcard ~/.screenrc))
	make screen
endif
ifneq (,$(wildcard ~/.config/i3/config))
	make i3
endif
ifneq (,$(wildcard ~/.config/i3blocks))
	make i3blocks
endif

vim: ## vim and plugins
	@echo "Updating vim..."
	-cp -f ~/.vimrc ~/.vimrc.bak
	-rm -Rf ~/.vim.bak
	-cp -Rf ~/.vim ~/.vim.bak
	cp configs/vim/vimrc ~/.vimrc
	@echo "Please run :PluginInstall in vim"

x11: ## Manages some X11 configuration files
	@echo "Updating x11 files..."
	-cp -f ~/.Xresources ~/.Xresources.bak
	cp configs/X11/Xresources ~/.Xresources

i3: ## Configures i3 window manager
	@echo "Updating i3..."
	-cp -f ~/.config/i3/config ~/.config/i3/config.bak
	cp configs/i3/config ~/.config/i3/config 

i3blocks: ## Configures i3blocks and i3blocks scripts
	@echo "Updating i3blocks and scripts..."
	-tar -zcf ~/.config/i3blocks/scripts.bak.tar.gz ~/.config/i3blocks/scripts
	-rm -Rf ~/.config/i3blocks/scripts
	-cp -f ~/.config/i3blocks/config ~/.config/i3blocks/config.bak
	cp configs/i3blocks/config ~/.config/i3blocks/config
	cp -R configs/i3blocks/scripts ~/.config/i3blocks/scripts

tmux: ## Configures tmux
	@echo "Updating tmux..."
	-cp -f ~/.tmux.conf ~/.tmux.conf.bak
	cp -f configs/tmux/tmux.conf ~/.tmux.conf

screen: ## Configures GNU/Screen
	@echo "Updating screen..."
	-cp -f ~/.screenrc ~/.screenrc.bak
	cp -f configs/screen/general.screenrc ~/.screenrc

collect: ## Collects the current local files on this repository
ifneq (,$(wildcard ~/.vimrc))
	-cp -f ~/.vimrc configs/vim/vimrc
endif
ifneq (,$(wildcard ~/.tmux.conf))
	-cp -f ~/.tmux.conf configs/tmux/tmux.conf
endif
ifneq (,$(wildcard ~/.screenrc))
	-cp -f ~/.screenrc configs/screen/general.screenrc
endif
ifneq (,$(wildcard ~/.config/i3/config))
	-cp -f ~/.config/i3/config configs/i3/config
endif
ifneq (,$(wildcard ~/.config/i3blocks))
	-cp -f ~/.config/i3blocks/config configs/i3blocks/config
	-cp -Rf ~/.config/i3blocks/scripts/* configs/i3blocks/scripts/
endif
ifneq (,$(wildcard ~/.Xresources))
	-cp -f ~/.Xresources configs/X11/Xresources
endif

release: ## Release local configuration to github
	make collect
	@echo "Pushing to github..."
	git add .
	git commit
	git push origin master

