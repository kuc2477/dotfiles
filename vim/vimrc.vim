"NOT COMPATIBLE TO LEGACY VI VERSIONS
set nocompatible

let g:plug_timeout = 300
let s:osname = substitute(system('uname'), "\n", "", "")
let s:username = substitute(system('whoami'), "\n", "", "")

" PLATFORM DEPENDENT VALUES
if s:osname == 'Darwin'
    let s:HOME_PATH = '/Users/'.s:username
    let g:INSTALLER = 'brew install '
    let g:NAME_CTAGS = 'ctags'
else
    let s:HOME_PATH = '/home/'.s:username
    let g:INSTALLER = 'sudo apt get install '
    let g:NAME_CTAGS = 'exuberant-ctags'
endif

"============================Plug List======================================"

filetype off
call plug#begin('~/.vim/plugged')

" Autocompletion interfaces
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'zchee/deoplete-jedi', { 'do': 'pip install jedi' }
Plug 'ervandew/supertab'

" Linting interface
Plug 'scrooloose/syntastic', {
            \'do':
            \'sudo pip install flake8 yamllint && ' .
            \'sudo npm -g install eslint && ' .
            \g:INSTALLER .  'shellcheck'
            \}

" Easy Commenting
Plug 'scrooloose/nerdcommenter'

" Vim feature extensions
Plug 'tpope/vim-obsession'
Plug 'Shougo/vimproc.vim'

" Visual supports
Plug 'severin-lemaignan/vim-minimap'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sjl/gundo.vim'
Plug 'kshenoy/vim-signature'
Plug 'pgdouyon/vim-evanesco'
Plug 'gorkunov/smartpairs.vim'
Plug 'myusuf3/numbers.vim'
Plug 'ntpeters/vim-better-whitespace'

" File navigation
Plug 'burke/matcher', { 'do': 'sudo make && make install' }
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'jeetsukumaran/vim-buffergator'

" Git interface
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

" Text objects / editing supports
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mattn/emmet-vim'
Plug 'godlygeek/tabular'
Plug 'kuc2477/vim-move'

" Motion
Plug 'Lokaltog/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-smooth-scroll'

" Tag
Plug 'xolox/vim-easytags', { 'do': g:INSTALLER . g:NAME_CTAGS }
Plug 'majutsushi/tagbar', { 'do': 'sudo stack install ghc-mod hasktags' }

" Snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Miscs
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'reedes/vim-pencil'
Plug 'jceb/vim-orgmode'
Plug 'reedes/vim-wordy'
Plug 'mickaobrien/vim-stackoverflow'
Plug 'ryanss/vim-hackernews'
Plug 'tyru/open-browser.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mhinz/vim-startify'
Plug 'esneider/YUNOcommit.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'jez/vim-superman'
Plug 'Valloric/ListToggle'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'altercation/vim-colors-solarized'

" Python
Plug 'davidhalter/jedi-vim', { 'do': 'pip install jedi' }
Plug 'hynek/vim-python-pep8-indent'
Plug 'ehamberg/vim-cute-python'
Plug 'vim-scripts/django.vim'

" Javascript / JSX
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'heavenshell/vim-jsdoc'

" Haskell
Plug 'Twinside/vim-syntax-haskell-cabal'    " Cabal syntax.
Plug 'dag/vim2hs'                           " Syntax highlighting, unicode conceals.
Plug 'eagletmt/ghcmod-vim'                  " Use ghc-mod for type information and linting.
Plug 'eagletmt/neco-ghc'                    " Use neco-ghc for neocomplete haskell completion
                                            " backend.
Plug 'Twinside/vim-hoogle'

" Octave
Plug 'jvirtanen/vim-octave'

" Bash
Plug 'kuc2477/bash-support.vim'

" HTML5
Plug 'Valloric/MatchTagAlways'
Plug 'othree/html5.vim'

" CSS / LESS / SCSS
Plug 'JulesWang/css.vim'
Plug 'groenewege/vim-less'
Plug 'cakebaker/scss-syntax.vim'
Plug 'ap/vim-css-color'

" JSON
Plug 'elzr/vim-json'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', { 'do': 'sudo npm -g install instant-markdown-d' }

" RsT
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst', { 'do': 'sudo pip install instant-rst' }

" LaTeX
Plug 'lervag/vimtex'

" Thrift
Plug 'solarnz/thrift.vim'

" Groovy
Plug 'vim-scripts/groovy.vim'
Plug 'vim-scripts/groovyindent-unix'

call plug#end()
filetype plugin indent on


"=============================Plug Settings================================="

" Deoplete
let g:deoplete#enable_at_startup = 1

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Nerdtree
map <leader>o :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Buffergator
let g:buffergator_supress_keymaps = 1
noremap l; :BuffergatorToggle<CR>

" Easymotion
let g:EasyMotion_smartcase = 1
nmap <C-f> <Plug>(easymotion-sn)

" Fzf
let g:fzf_layout = { 'down': '~20%' }


" Ctrlp
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = {'dir': 'data'}

" Ctrlp-Funky
nnoremap <leader>f :CtrlPFunky<Cr>
nnoremap <leader>F :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_type_haskell = {
    \ 'ctagsbin': 'hasktags',
    \ 'ctagsargs': '-x -c -o-',
    \ 'kinds': [
    \    'm:modules:0:1',
    \    'd:data: 0:1',
    \    'd_gadt: data gadt:0:1',
    \    't:type names:0:1',
    \    'c:classes:0:1',
    \    'cons:constructors:1:1',
    \    'c_gadt:constructor gadt:1:1',
    \    'c_a:constructor accessors:1:1',
    \    'ft:function types:1:1',
    \    'fi:function implementations:0:1',
    \    'o:others:0:1'
    \ ],
    \ 'sro': '.',
    \ 'kind2scope': {
    \    'm': 'modules',
    \    'c': 'class',
    \    'd': 'data',
    \    't': 'type'
    \ },
    \ 'scope2kind': {
    \    'module': 'm',
    \    'class': 'c',
    \    'data': 'd',
    \    'type': 't'
    \ }
\}
nnoremap <S-u> :TagbarToggle<CR>

" MatchTagAlways
let g:mta_filetypes = {
    \ 'html': 1,
    \ 'xhtml': 1,
    \ 'xml': 1,
    \ 'javascript.jsx': 1
    \ }

" Vim-indent-guides
hi IndentGuidesOdd ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" Vim-smooth-scroll
noremap <silent> gk :call smooth_scroll#up(&scroll, 0, 9)<CR>
noremap <silent> gj :call smooth_scroll#down(&scroll, 0, 9)<CR>
noremap <silent> gkk :call smooth_scroll#up(&scroll*2, 0, 9)<CR>
noremap <silent> gjj :call smooth_scroll#down(&scroll*2, 0, 9)<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsJumpForwardTrigger="<C-e>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"
let g:UltiSnipsEditSplit="vertical"

" Syntastic
set statusline+=%#waringmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_loc_list_height=3
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic language specific settings
let g:syntastic_python_python_exec = '~/.pyenv/shims/python' " use python3 syntax
let g:syntastic_javascript_checkers = ['eslint']    " use eslint for javascript
let g:syntastic_html_tidy_exec = 'tidy'             " use tidy for html5
let g:syntastic_mode_map = {
            \'mode': 'active',
            \'passive_filetypes': ['haskell']
            \}                                     " we use ghc-mod-vim for lint

" Gundo
map <F3> :GundoToggle<CR>

" Fugitive
map <F4> :Gdiff<CR>
map <F5> :Gstatus<CR>
map <F6> :Gcommit<CR>
map <F7> :Gpull
map <F8> :Gpush

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'
set laststatus=2

" Numbers
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'markdown', 'rst']

" Startify
let g:startify_custom_header =
    \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['', '']

" Vim-colorscheme-switcher
let g:colorscheme_switcher_define_mappings = 0
nnoremap <leader>]] :NextColorScheme<CR>
nnoremap <leader>[[ :PrevColorScheme<CR>

" Vim-move
let g:move_key_modifier = 'C'

" Vim-sneak
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

" Vim-expand-region
vmap <C-]> <Plug>(expand_region_expand)
vmap <C-[> <Plug>(expand_region_shrink)


" ghc-mod-vim
au FileType haskell nnoremap <buffer> t :GhcModInfo<CR>
au FileType haskell nnoremap <buffer> T :GhcModType<CR>
au FileType haskell nnoremap <buffer> <leader>t :GhcModTypeClear<CR>
au BufReadPost *.hs GhcModCheckAndLintAsync
au BufWritePost *.hs GhcModCheckAndLintAsync

" Jedi-vim
au filetype python let g:jedi#completions_enabled = 1
au filetype python let g:jedi#goto_definitions_command = ''
au filetype python let g:jedi#goto_assignments_command = ''
au filetype python let g:jedi#usages_command = ''
au filetype python let g:jedi#popup_on_dot = 0
au filetype python let g:jedi#popup_select_first = 1
au filetype python let g:jedi#use_splits_not_buffers = 'winwidth'

" vim-jsx
let g:jsx_ext_required = 0

" javascript-libraries-syntax
au filetype javascript let g:used_javascript_libs =
            \'underscore, jquery, requirejs, backbone, react, jasmine'

" Ag
let g:ag_prg="ag --column --nogroup --noheading"

" Tmux
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        silent! execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
            call system("tmux select-pane -" . a:tmuxdir)
            redraw!
        endif
    endfunction

    let previous_title = substitute(system("tmux display-message -p '#(pane_title)'"), '\n', '', '')
    let &t_ti = "\<ESC>]2:vim\<Esc>\\" . &t_ti
    let &t_te = "\<ESC>]2:". previous_title . "\<ESC>\\" . &t_te

    nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
    nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
    nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
    nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
else
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
endif

" vimux
map <leader>vp :VimuxPromptCommand<CR>
map <leader>vl :VimuxRunLastCommand<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vx :VimuxInterruptRunner<CR>

" vim-instant-markdown
let g:instant_markdown_autostart = 0

" vim-better-whitespace
autocmd FileType python,javascript,javascript.jsx,html,htmldjango autocmd BufEnter * EnableStripWhitespaceOnSave


"============================General Settings================================"

" Add user local bin to runtime path
let $PATH = $PATH . ':' . expand("~/.local/bin")

" Encoding
set enc=utf-8

" Enable alternate input methods
set noimd
set imi=1
set ims=-1

" Color scheme
syntax on
set background=dark
colorscheme wombat256i

" Terminal
if !has('nvim')
	set term=xterm-256color
endif
if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

" Set short timeout on insert mode
set timeoutlen=300
au InsertEnter * set timeoutlen=95
au InsertLeave * set timeoutlen=300

" Enable backsapce over everythin in insert mode
set backspace=indent,eol,start

" Clipboard
set clipboard=unnamed

" Indentations
set expandtab
set smarttab
set smartindent
set shiftwidth=4
set tabstop=4

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Completion list maximum length
set ph=20

" Settings for display
set nu
set colorcolumn=79
highlight ColorColumn ctermbg=red ctermfg=white cterm=bold

" Key mappings
nnoremap <F9> :tabnew<CR>
nnoremap <F10> :tabclose<CR>
nnoremap gr :tabprevious<CR>
nnoremap - :res -10<CR>
nnoremap = :res +10<CR>
nnoremap _ :vertical res -10<CR>
nnoremap + :vertical res +10<CR>

" Writing mode
function! ToggleWritingMode()
    if g:in_writing_mode
        let g:in_writing_mode=0
        let g:vim_markdown_folding_disabled=1
        :PencilOff
    else
        let g:in_writing_mode=1
        let g:vim_markdown_folding_disabled=0
        :Pencil
    endif
    :Goyo
endfunction
let g:in_writing_mode=0
nnoremap <leader>w :call ToggleWritingMode()<CR>

" Life is short
vmap <silent> jk <ESC>
imap <silent> jk <ESC>
nnoremap <silent>gh zz
nnoremap ; :
vnoremap ; :

" Use Ag if both ag and matcher is available
if executable('ag') && executable('matcher!')
    map <F2> :Ag TODO<CR>
    " user ag over grep

    set grepprg=ag\ --nogroup\ --nocolor
    " user ag in ctrlp
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g""'
    " age is fast enough that ctrlp doesn't need to cache
    let g:ctrlp_use_caching = 0
    " apply matcher to ctrlp
    let g:ctrlp_match_func = { 'match': 'GoodMatch' }

    function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
        " create a cache file if note yet exists
        let cachefile = ctrlp#utils#cachedir().'matcher.cache'
        if ! (filereadable(cachefile) && a:items == readfile(cachefile))
            call writefile(a:items, cachefile)
        endif
        if !filereadable(cachefile)
            return []
        endif

        " a:mmode is currently ignored. In the future, we should probably do
        " something about that. the matcher behaves like 'full-line'.
        let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
        if !(exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles)
            let cmd = cmd.'--no-dotfiles '
        endif

        let cmd = cmd.a:str
        return split(system(cmd), "\n")
    endfunction
else
    map <F2> :vimgrep /\<TODO\>/j **/*.py **/.*js **/*.html \| :cope<CR>
endif


"==========================Language Shim Settings============================="

" Javascript
au FileType javascript let g:jsdoc_default_mapping = 1
au FileType javascript noremap <C-e> :JsDoc<CR>
au FileType javascript nnoremap ]] /\(function\s*(.*)\s*{\\|=>\s*{\)<CR>
au FileType javascript nnoremap [[ ?\(function\s*(.*)\s*{\\|=>\s*{\)<CR>

" Haskell
au FileType haskell let g:haskellmode_completion_ghc = 0         "turn off haskell mode completion
au FileType haskell let g:necoghc_enable_detailed_browse = 1     "use detailed browse
au FileType haskell setlocal omnifunc=necoghc#omnifunc

" Octave
au BufRead,BufNewFile *.m,*.oct setfiletype octave
au FileType octave if &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif

" Miscs
au! BufRead,BufNewFile Jenkinsfile setfiletype groovy
au! BufRead,BufNewFile *.lr setfiletype markdown
au! BufRead,BufNewFile *.md setfiletype markdown
au! BufRead,BufNewFile *.cabal setfiletype haskell
au! BufRead,BufNewFile *.wsgi setfiletype python
au! BufRead,BufNewFile *.less setfiletype less
au! BufRead,BufNewFile *.json,*.babelrc,*.eslintrc setfiletype json
au! BufRead,BufNewFile *.html setfiletype htmldjango
au FileType html setl ts=2 sw=2 sts=2

" Indentations
au FileType bash,sh setl ts=2 sw=2 sts=2
au FileType haskell setl sw=2
au FileType thrift setl ts=2 sw=2 sts=2
au FileType javascript setl ts=2 sw=2 sts=2
au FileType html,htmldjango setl ts=2 sw=2 sts=2
au FileType yaml,yml setl ts=2 sw=2 sts=2 expandtab
au FileType css,scss,sass,less setl ts=2 sw=2 sts=2
