# vimsettings

*Ha Junsoo's vim configuration focused on Python / Javascript / Haskell development in linux environment*


# Requirements

* Requires vim 7.4+ compiled with python, ruby and lua interpreters.
* Requires root privilege for global installation of lang specific toolchains.
* [bashdb](http://bashdb.sourceforge.net/)
* [cmake](https://cmake.org/)
* [pip](https://pypi.python.org/pypi/pip)
* [npm](https://www.npmjs.com/)
* [stack](https://github.com/commercialhaskell/stack)
* [ctags](http://ctags.sourceforge.net/)


# Note

* Syntastic lint configuration for python expects pyenv version `3.5.1`.


# Install

```shell
./install.sh
```

# Features

**Bash**
* *Autocompletion*: `neocomplete`
* *Syntax highlight / Lint / Fold*: `bash-support.vim`

**Python**
* *Autocompletion:* `YouCompleteMe` powered by `jedi`
* *Refactoring / Code navigation*: `jedi-vim`
* *Lint*: `Syntastic` powered by `flake8`
* *Django template syntax highlight*: `django.vim`

**Javascript / JSX**
* *Autocompletion*: `YouCompleteMe` powered by `tern_for_vim`
* *Indentation / Syntax highlight*: `vim-javascript`
* *Lint*: `Syntastic` powered by `eslint`
* *JSX syntax highlight*: `vim-jsx`
* *Autodoc*: `vim-jsdoc`

**Haskell**
* *Autocompletion*: `neocomplete` powered by `neco-ghc`
* *Indentation / Syntax highlight / Unicode conceal*: `vim2hs`
* *Type inspection / Expansion*: `ghcmod-vim`

**HTML5 / Mustache / Handlebars**
* *Tag match*: `closetag` and `MatchTagAlways`
* *HTML5 syntax highlight*: `html5.vim`
* *Mustache / Handlebars syntax highlight*:`vim-mustatch-handlebars`

**CSS / LESS / SCSS**
* *CSS syntax highlight*: `css.vim`
* *LESS syntax highlight*: `vim-less`
* *SCSS syntax highlight*: `scss-syntax`

**JSON / Markdown / RST**
* *JSON lint / syntax highlight / conceals*: `vim-json`
* *Markdown syntax highlight / Fold*: `vim-markdown`
* *Markdown Instant preview*: `vim-instant-markdown`
* *RsT syntax highlight / Fold*: `riv.vim`
* *RsT instant preview*: `InstantRst`

**Others**
* *Filesystem navigation*: `nerdtree`
* *Quick commenting*: `nerdcommenter`
* *Powerline*: `vim-airline`
* *Fuzzy finding within a file*: `vim-easymotion`
* *Fuzzy finding within a filesystem*: `ctrlp`
* *Lightning file search*: `ag`
* *Undo*: `gundo`
* *Git interface*: `vim-fugitive`
* *Vim session recording*: `vim-obsession`
* *Spell check*: `vim-wordy`
* *Graphical mark*: `vim-signature`
* *Surround*: `vim-surround`
* *Quick delimitmating*: `delimitMate`
* *Search highlight*: `vim-evanesco`

*and more..*
