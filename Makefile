SHELL = /bin/bash


all: font utils bash tmux vim python javascript haskell

submodules:
	git submodule update --init

font: submodules
	./fonts/install.sh

utils:
	# autoenv, autojump, ag
	pip install autoenv
	sudo apt-get install autojump silversearcher-ag

bash: submodules font
	cd bash
	# powerline binding & configuration paths
	sudo pip install powerline-status powerline-gitstatus
	root_dir=`pip show powerline-status | grep -i location | grep -Eo /.*$$`
	bash_binding=$$root_dir/powerline/bindings/bash/powerline.sh
	config_dir=`pwd`/powerline-configs
	# powerline binding & configuration installation
	mkdir -p ~/.config/powerline/themes/shell
	ln -sfi $$bash_binding ~/.powerline
	ln -sfi $$config_dir/config.json \
		~/.config/powerline/config.json
	ln -sfi $$config_dir/colorscheme.json \
		~/.config/powerline/colorschemes/default.json
	ln -sfi $$config_dir/theme.json \
		~/.config/powerline/themes/shell/default.json
	# bash configuration
	ln -sfi `pwd`/bashrc ~/.bashrc

tmux: submodules font
	cd tmux
	# tmux binary
	sudo apt-get install libevent-dev
	(cd tmux-src && ./autogen.sh && ./configure && make && sudo make install)
	# tmux powerline
	ln -sfi `pwd`/tmux-powerline ~/.tmux-powerline
	ln -sfi `pwd`/tmux-powerlinerc ~/.tmux-powerlinerc
	# tmux configuration
	ln -sfi `pwd`/`dirname $$0`/tmux ~/.tmux
	ln -sfi `pwd`/`dirname $$0`/tmux.conf ~/.tmux.conf

vim-bin-deps:
	sudo apt-get build-dep
	sudo apt-get install \
		liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev \
		libperl-dev libncurses5-dev libgnome2-dev libgnomeui-dev \
		libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev \
		libx11-dev libxpm-dev libxt-dev
	# copy lua header files to target directory of vim build path
	sudo mkdir /usr/include/lua5.1/include
	sudo cp /usr/include/lua5.1/*.h /usr/include/lua5.1/include/

vim-bin: vim-deps
	cd vim/vim-src
	make distclean
	./configure --with-features=huge \
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
	make && sudo make install

vim-deps:
	sudo apt-get install bashdb cmake exuberant-ctags

vim: vim-bin vim-deps font
	cd vim
	# vim plugin manager
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	   	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	# vim configuration
	ln -sfi `pwd`/vimrc ~/.vimrc
	# vim plugins
	vim +PlugInstall +VimProcInstall +qall

python: python-deps
	# pyenv dependencies
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
		libncurses5-dev
	# pyenv
	curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/\
		master/bin/pyenv-installer | bash
	# pyenv-virtualenv
	git clone \
	  https://github.com/yyuu/pyenv-virtualenv.git \
	  ~/.pyenv/plugins/pyenv-virtualenv

javascript:
	# nvm
	curl -o- https://raw.githubusercontent.com/creationix/nvm/\
		v0.29.0/install.sh | bash

haskell:
	# stack
	sudo apt-key adv \
		--keyserver keyserver.ubuntu.com \
		--recv-keys 575159689BEFB442
	echo 'deb http://download.fpcomplete.com/ubuntu trusty main' | \
	   	sudo tee /etc/apt/sources.list.d/fpco.list
	sudo apt-get update && sudo apt-get install stack -y

