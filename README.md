# dotfiles
My private environment files for UNIX like systems. **Supports OS X / Debian out of the box**.

![terminal screenshot](/terminal.png?raw=true "terminal screenshot")


## Dependencies
- python
- bash
- git
- curl


## What's in it?
- neovim + deoplete + syntastic + tmux for **[UNIX philosophy compliant development]**
- pyenv + nvm + stack for **sandboxed development in Python, JavaScript and Haskell**
- autojump, autoenv, tig, ranger, fzf, saws, TermFeed and other **cute CLI goodies**


## How can I use it?
![installation recording](/tty.gif?raw=true "installation recording")

    $ ./install [--no-sudo] {vim, vimrc, python, javascript, haskell, bashrc, tmuxrc, powerline, themes, utils, jupyter_configs}


### Options
- `[--no-sudo]`: Installation targets that requires root authority will be skipped

### Targets
- `vim`: [neovim] binary
- `vimrc`: `vimrc`  and it's plugins
- `python`: [pyenv] and `pythonrc`
- `javascript`: [nvm] and `tern-project`
- `haskell`: [stack]
- `bashrc`: `bashrc`
- `powerline`: `powerline` and it's configurations
- `tmux`: [tmux] binary
- `tmuxrc`: `tmuxrc`, [tmux-powerline] and it's configurations
- `utils`: `bins/`, [fzf], [pgweb], [ag], [ranger], [tig], [irssi], [pv], [jq], [jid], [httpie] and more
- `themes`: Terminal themes
- `jupyter_configs`: Jupyter Notebook configurations


## Note
- This environment has been used and tested only in OS X / Debian systems.
- Edit your terminal profiles to use installed powerline fonts.


## License
- MIT


[unix philosophy compliant development]: https://en.wikipedia.org/wiki/Unix_philosophy
[pyenv]: https://github.com/pyenv/pyenv
[neovim]: https://neovim.io/
[nvm]: https://github.com/creationix/nvm
[fzf]: https://github.com/junegunn/fzf
[pgweb]: https://github.com/sosedoff/pgweb
[ag]: https://github.com/ggreer/the_silver_searcher
[ranger]: https://github.com/ranger/ranger
[tig]: https://github.com/jonas/tig
[irssi]: https://irssi.org/
[pv]: http://www.ivarch.com/programs/pv.shtml
[jq]: 200~https://github.com/stedolan/jq
[jid]: https://github.com/simeji/jid
[httpie]: https://github.com/jakubroztocil/httpie
