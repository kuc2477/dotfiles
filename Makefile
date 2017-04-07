SHELL = /bin/bash
.PHONY: font utils bin terminal bash tmux vim-bin vim python javascript haskell


# DIRNAMES
FONT_DIRNAME = fonts
TMUX_DIRNAME = tmux
VIM_DIRNAME = vim
BASH_DIRNAME = bash
JS_DIRNAME = javascript
TERMINAL_DIRNAME = terminal
PYTHON_DIRNAME = python
BIN_DIRNAME = bins

# PLATFORM DEPENDENT NAMES
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


# =================
# COMPOSITE TARGETS
# =================
#
all: font utils bash tmux vim python javascript haskell

environment: terminal bash tmux bin utils

langs: python java javascript haskell

editor: vim


# =======
# TARGETS
# =======

ifneq ($(OS),Darwin)
	$(INSTALLER) python python-pip
	sudo apt-get install xdg-utils
endif

submodules:
	git submodule update --init

font: submodules
	$(FONT_DIRNAME)/install.sh

utils: base
	# autoenv, autojump, ag
	sudo pip install autoenv pgcli
	$(INSTALLER) autojump $(NAME_AG) ranger tig
	# fzf
	if [ ! -d "$$HOME/.fzf" ]; then git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all; fi

bin:
ifneq ($(OS),Darwin)
	sudo chown -R `whoami` /usr/local/bin
	sudo cp ./bin/* /usr/local/bin
else
	brew cask install pgweb
endif

terminal: font
ifneq ($(OS),Darwin)
	# gnome terminal profile
	ln -sfi $(TERMINAL_DIRNAME)/%gconf.xml ~/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml
endif

bash: submodules font base
	# install powerline
ifeq ($(OS),Darwin)
	pip install powerline-status powerline-gitstatus
else
	sudo pip install powerline-status powerline-gitstatus
endif
	# install powerline binding and configurations
	root_dir=`sudo pip show powerline-status | grep -i location | grep -Eo \/.*$$`; \
	bash_binding=$$root_dir/powerline/bindings/bash/powerline.sh; \
	config_dir=`pwd`/$(BASH_DIRNAME)/powerline-configs; \
	mkdir -p ~/.config/powerline/colorschemes; \
	mkdir -p ~/.config/powerline/themes/shell; \
	sudo ln -sf $$bash_binding ~/.powerline; \
	sudo ln -sf $$config_dir/config.json ~/.config/powerline/config.json; \
	sudo ln -sf $$config_dir/colorscheme.json ~/.config/powerline/colorschemes/default.json; \
	sudo ln -sf $$config_dir/theme.json ~/.config/powerline/themes/shell/default.json
	# install autocompletions
	$(INSTALLER) bash-completion
	ln -sf `pwd`/$(BASH_DIRNAME)/autocompletions/git-completion.bash ~/.git-completion.bash
	ln -sf `pwd`/$(BASH_DIRNAME)/autocompletions/docker-completion.bash ~/.docker-completion.bash
	ln -sf `pwd`/$(BASH_DIRNAME)/autocompletions/docker-compose-completion.bash ~/.docker-compose-completion.bash
	# install bash configuration
ifeq ($(OS),Darwin)
		ln -sf `pwd`/$(BASH_DIRNAME)/bashrc ~/.profile
else
		ln -sf `pwd`/$(BASH_DIRNAME)/bashrc ~/.bashrc
endif

tmux: submodules font
	# tmux binary
ifeq ($(OS),Darwin)
	$(INSTALLER) libevent automake pkg-config
	$(INSTALLER) reattach-to-user-namespace
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
ifeq ($(OS),Darwin)
	brew install lua
else
	sudo apt-get install build-essential
	sudo apt-get install \
		liblua5.2-dev luajit libluajit-5.2 python-dev ruby-dev \
		libperl-dev libncurses5-dev libgnome2-dev libgnomeui-dev \
		libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev \
		libx11-dev libxpm-dev libxt-dev
	# copy lua header files to target directory of vim build path
	sudo mkdir -p /usr/include/lua5.2/include
	sudo cp /usr/include/lua5.2/*.h /usr/include/lua5.2/include/
endif

vim-bin: submodules vim-bin-deps
ifneq ($(OS),Darwin)
	cd $(VIM_DIRNAME)/vim-src && ./configure --with-features=huge \
	   	--enable-rubyinterp \
	   	--enable-largefile \
	   	--disable-netbeans \
	   	--enable-pythoninterp \
	   	--with-python-config-dir=/usr/lib/python2.7/config \
	   	--enable-perlinterp \
	   	--enable-luainterp \
	   	--with-luajit \
	   	--with-lua-prefix=/usr/local/include/lua5.2 \
	   	--enable-gui=auto \
	   	--enable-fail-if-missing \
	   	--enable-cscope
	cd $(VIM_DIRNAME)/vim-src && make && sudo make install
else
	brew install macvim --with-cscope --with-lua --with-override-system-vim
endif

vim-deps:
	$(INSTALLER) bashdb cmake $(NAME_CTAGS)

vim: vim-bin vim-deps font base
	# vim plugin manager
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	   	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	# vim configuration
	ln -sfi `pwd`/$(VIM_DIRNAME)/vimrc ~/.vimrc
	# vim plugins
	vim +PlugInstall +VimProcInstall +qall

python: base
ifneq ($(OS),Darwin)
	# pyenv dependencies
	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
		libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
		libncurses5-dev
endif
	# pyenv
ifeq ($(OS),Darwin)
	command -v pyenv >/dev/null || (brew update && brew install pyenv pyenv-virtualenv)
else
	command -v pyenv >/dev/null || (curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash)
endif
	# install pypirc, pythonrc, pdbrc
	ln -sf `pwd`/$(PYTHON_DIRNAME)/pypirc $$HOME/.pypirc
	ln -sf `pwd`/$(PYTHON_DIRNAME)/pythonrc.py $$HOME/.pythonrc.py
	ln -sf `pwd`/$(PYTHON_DIRNAME)/pdbrc.py $$HOME/.pdbrc.py

java:
	#jenv
	git clone https://github.com/gcuisinier/jenv.git ~/.jenv


javascript:
	# nvm
	command -v nvm >/dev/null || (curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash)
	nvm install node
	# tern
	ln -sf `pwd`/$(JS_DIRNAME)/tern-project ~/.tern-project

haskell:
	# stack
	curl -sSL https://get.haskellstack.org/ | sh
