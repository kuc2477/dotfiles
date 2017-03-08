SHELL = /bin/bash
.PHONY: font utils bin terminal bash tmux vim-bin vim python javascript haskell

OS := $(shell uname)

ifeq ($(OS),Darwin)
INSTALLER := brew install
NAME_AG := the_silver_searcher
NAME_CTAGS := ctags
else
INSTALLER := sudo apt-get install
NAME_AG := silversearcher-ag
NAME_CTAGS := exuberant-ctags
endif

FONT_DIRNAME = fonts
TMUX_DIRNAME = tmux
VIM_DIRNAME = vim
BASH_DIRNAME = bash
JS_DIRNAME = javascript
TERMINAL_DIRNAME = terminal
BIN_DIRNAME = bins


all: font utils bash tmux vim python javascript haskell

base:
	sudo apt-get install python python-pip
	sudo apt-get install xdg-utils

submodules:
	git submodule update --init

font: submodules
	$(FONT_DIRNAME)/install.sh

utils:
	# autoenv, autojump, ag
	sudo pip install autoenv pgcli
	$(INSTALLER) autojump $(NAME_AG)

bin:
ifeq ($(OS),Darwin)
	sudo chown june -R /usr/local/bin
endif
	sudo cp ./bin/* /usr/local/bin

terminal: font
ifeq ($(OS),Darwin)
	# gnome terminal profile
	ln -sfi $(TERMINAL_DIRNAME)/%gconf.xml ~/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml
endif

bash: submodules font
	# powerline binding & configuration path installations
ifeq ($(OS),Darwin)
	pip install --user powerline-status powerline-gitstatus
else
	sudo pip install powerline-status powerline-gitstatus
endif
	root_dir=`sudo pip show powerline-status | grep -i location | grep -Eo \/.*$$`; \
	bash_binding=$$root_dir/powerline/bindings/bash/powerline.sh; \
	config_dir=`pwd`/$(BASH_DIRNAME)/powerline-configs; \
	mkdir -p ~/.config/powerline/colorschemes; \
	mkdir -p ~/.config/powerline/themes/shell; \
	sudo ln -sf $$bash_binding ~/.powerline; \
	sudo ln -sf $$config_dir/config.json ~/.config/powerline/config.json; \
	sudo ln -sf $$config_dir/colorscheme.json ~/.config/powerline/colorschemes/default.json; \
	sudo ln -sf $$config_dir/theme.json ~/.config/powerline/themes/shell/default.json
	# bash configuration
ifeq ($(OS),Darwin)
		sudo ln -sf `pwd`/$(BASH_DIRNAME)/bashrc ~/.profile
else
		sudo ln -sf `pwd`/$(BASH_DIRNAME)/bashrc ~/.bashrc
endif

tmux: submodules font
	# tmux binary
ifeq ($(OS),Darwin)
	$(INSTALLER) libevent automake pkg-config
else
	$(INSTALLER) libevent-dev automake libncurses-dev pkg-config
endif
	(cd $(TMUX_DIRNAME)/tmux-src && ./autogen.sh && ./configure && make && sudo make install)
	# tmux powerline
	ln -sf `pwd`/$(TMUX_DIRNAME)/tmux-powerline ~/.tmux-powerline
	ln -sf `pwd`/$(TMUX_DIRNAME)/tmux-powerlinerc ~/.tmux-powerlinerc
	# tmuxp
	sudo pip install tmuxp
	# tmux configuration
	ln -sf `pwd`/$(TMUX_DIRNAME)/tmux ~/.tmux
	ln -sf `pwd`/$(TMUX_DIRNAME)/tmux.conf ~/.tmux.conf

vim-bin-deps:
	sudo apt-get install build-essential
	sudo apt-get install \
		liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev \
		libperl-dev libncurses5-dev libgnome2-dev libgnomeui-dev \
		libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev \
		libx11-dev libxpm-dev libxt-dev
	# copy lua header files to target directory of vim build path
	sudo mkdir -p /usr/include/lua5.1/include
	sudo cp /usr/include/lua5.1/*.h /usr/include/lua5.1/include/

vim-bin: submodules vim-bin-deps
	cd $(VIM_DIRNAME)/vim-src && ./configure --with-features=huge \
	   	--enable-rubyinterp \
	   	--enable-largefile \
	   	--disable-netbeans \
	   	--enable-pythoninterp \
	   	--with-python-config-dir=/usr/lib/python2.7/config \
	   	--enable-perlinterp \
	   	--enable-luainterp \
	   	--with-luajit \
	   	--enable-gui=auto \
	   	--enable-fail-if-missing \
	   	--with-lua-prefix=/usr/include/lua5.1 \
	   	--enable-cscope
	cd $(VIM_DIRNAME)/vim-src && make && sudo make install

vim-deps:
	$(INSTALLER) bashdb cmake $(NAME_CTAGS)

vim: vim-bin vim-deps font
	# vim plugin manager
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	   	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	# vim configuration
	ln -sfi `pwd`/$(VIM_DIRNAME)/vimrc ~/.vimrc
	# vim plugins
	vim +PlugInstall +VimProcInstall +qall

python:
ifneq ($(OS),Darwin)
	# pyenv dependencies
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
		libncurses5-dev
endif
	# pyenv
ifeq ($(OS),Darwin)
	brew update
	brew install pyenv pyenv-virtualenv
else
	curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
endif
	#pypi
	sudo ln -sfi `pwd`/python/pypirc $$HOME/.pypirc

java:
	#jenv
	git clone https://github.com/gcuisinier/jenv.git ~/.jenv


javascript:
	# nvm
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
	# tern
	ln -sfi `pwd`/$(JS_DIRNAME)/.tern-project ~/.tern-project

haskell:
	# stack
	sudo apt-key adv \
		--keyserver keyserver.ubuntu.com \
		--recv-keys 575159689BEFB442
	echo 'deb http://download.fpcomplete.com/ubuntu trusty main' | \
	   	sudo tee /etc/apt/sources.list.d/fpco.list
	sudo apt-get update && sudo apt-get install stack -y
