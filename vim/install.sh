#!/bin/bash


green() {
  # green echo
  tput setaf 2 && echo "$1" `tput sgr0`
}

install() {
  # install vim-plug
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # install vimrc and plugins
  ln -sfi `pwd`/`dirname $0`/vimrc $HOME/.vimrc
  vim +PlugInstall +VimProcInstall +qall
}


install && green "DONE"
