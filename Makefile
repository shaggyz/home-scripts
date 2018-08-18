help:
	@echo "Usage: make update"

update: ## Update the configuration in the current system.
	@echo "Updating local configuration from github..."
	git pull origin master
	make vim
	make tmux

vim:
	@echo "Updating vim..."
	./configs/vim/update.sh

tmux:
	@echo "Updating tmux..."
	cp -f ~/.tmux.conf ~/.tmux.conf.bak
	cp -f configs/tmux/tmux.conf ~/.tmux.conf

screen:
	@echo "Updating screen..."
	-cp -f ~/.screenrc ~/.screenrc.bak
	cp -f configs/screen/general.screenrc ~/.screenrc

release: ## Release local configuration to github
	@echo "Collecting local configuration..."
	./configs/vim/update.sh --repository
	cp -f ~/.tmux.conf configs/tmux/tmux.conf
	cp -f ~/.screenrc configs/screen/general.screenrc
	@echo "Pushing to github..."
	git add .
	git commit
	git push origin master

