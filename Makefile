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

vim: ## vim and plugins
	@echo "Updating vim..."
	./configs/vim/update.sh

x11: ## Manages some X11 configuration files
	@echo "Updating x11 files..."
	-cp -f ~/.Xresources ~/.Xresources.bak
	cp configs/X11/Xresources ~/.Xresources

i3: ## Configures i3 window manager
	@echo "Updating i3..."
	-cp -f ~/.config/i3/config ~/.config/i3/config.bak
	cp configs/i3/config ~/.config/i3/config 

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
	./configs/vim/update.sh --repository
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
ifneq (,$(wildcard ~/.Xresources))
	-cp -f ~/.Xresources configs/X11/Xresources
endif

release: ## Release local configuration to github
	make collect
	@echo "Pushing to github..."
	git add .
	git commit
	git push origin master

