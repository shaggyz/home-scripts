help:
	@echo "Usage: make update"

update: ## Update the configuration in the current system.
	@echo "Updating local configuration from github..."
	git pull origin master
	make vim
	make tmux
	make x11

vim:
	@echo "Updating vim..."
	./configs/vim/update.sh

x11:
	@echo "Updating x11 files..."
	-cp -f ~/.Xresources ~/.config/X11/Xresources.bak
	cp configs/X11/Xresources ~/.Xresources

i3:
	@echo "Updating i3..."
	-cp -f ~/.config/i3/config ~/.config/i3/config.bak
	cp configs/i3/config ~/.config/i3/config 

tmux:
	@echo "Updating tmux..."
	-cp -f ~/.tmux.conf ~/.tmux.conf.bak
	cp -f configs/tmux/tmux.conf ~/.tmux.conf

screen:
	@echo "Updating screen..."
	-cp -f ~/.screenrc ~/.screenrc.bak
	cp -f configs/screen/general.screenrc ~/.screenrc

collect:
	@echo "Collecting local configuration..."
	./configs/vim/update.sh --repository
	-cp -f ~/.tmux.conf configs/tmux/tmux.conf
	-cp -f ~/.screenrc configs/screen/general.screenrc
	-cp -f ~/.config/i3/config configs/i3/config
	-cp -f ~/.Xresources configs/X11/Xresources

release: ## Release local configuration to github
	make collect
	@echo "Pushing to github..."
	git add .
	git commit
	git push origin master

