"NOT COMPATIBLE TO LEGACY VI VERSIONS
set nocompatible


let g:plug_timeout = 300
let s:osname = substitute(system('uname'), "\n", "", "")
let s:username = substitute(system('whoami'), "\n", "", "")

"============================Plug List======================================"

filetype off
call plug#begin('~/.vim/plugged')

" Autocompletions
"Plug 'Shougo/deoplete.nvim',     { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi',      { 'do': 'pip install jedi', 'for': 'python' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'eagletmt/neco-ghc',        { 'do': 'stack install ghc-mod', 'for': 'haskell' }
Plug 'ervandew/supertab'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Coworking
Plug 'embear/vim-localvimrc'

" Linting interface
Plug 'scrooloose/syntastic', { 'do': 'pip install flake8 yamllint && ' }

" Text objects / Editing supports
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'lucapette/vim-textobj-underscore'
Plug 'michaeljsmith/vim-indent-object'
Plug 'coderifous/textobj-word-column.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'kuc2477/vim-move'
Plug 'tmhedberg/SimpylFold'

" Visual supports
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sjl/gundo.vim'
Plug 'kshenoy/vim-signature'
Plug 'pgdouyon/vim-evanesco'
Plug 'gorkunov/smartpairs.vim'
Plug 'myusuf3/numbers.vim'
Plug 'ntpeters/vim-better-whitespace'

" Browsing
Plug 'Numkil/ag.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree',          { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin',  { 'on': 'NERDTreeToggle' }
Plug 'jeetsukumaran/vim-buffergator'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'wellle/tmux-complete.vim'

" Git interface
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Writing
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-thematic'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Motion
Plug 'Lokaltog/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-smooth-scroll'
Plug 'reedes/vim-wheel'

" Tag
Plug 'xolox/vim-easytags', { 'on': 'TagbarToggle' }
Plug 'majutsushi/tagbar',  { 'do': 'stack install ghc-mod hasktags' }

" Miscs
Plug 'xolox/vim-misc'
Plug 'jceb/vim-orgmode'
Plug 'mhinz/vim-startify'
Plug 'esneider/YUNOcommit.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'chrisbra/unicode.vim'

" Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'roosta/vim-srcery'
Plug 'nightsense/carbonized'
Plug 'nightsense/wonka'
Plug 'ajmwagar/vim-deus'
Plug 'NLKNguyen/papercolor-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'nathanlong/vim-colors-writer'

" Python
Plug 'davidhalter/jedi-vim',         { 'do': 'pip install jedi' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'kuc2477/vim-cute-python',      { 'for': 'python' }
Plug 'vim-scripts/django.vim'

" Javascript / JSX
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'heavenshell/vim-jsdoc'

" Haskell
Plug 'Twinside/vim-syntax-haskell-cabal', { 'for': 'haskell'}
Plug 'dag/vim2hs',                        { 'for': 'haskell'} " syntax highlighting and unicode conceals.
Plug 'eagletmt/ghcmod-vim',               { 'for': 'haskell'} " use ghc-mod for type information and linting.
Plug 'Twinside/vim-hoogle',               { 'for': 'haskell'}

" Bash
Plug 'kuc2477/bash-support.vim', {'for': 'sh'}

" HTML5
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'htmldjango', 'javascript.jsx']}
Plug 'othree/html5.vim'

" CSS / LESS / SCSS
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'

" JSON
Plug 'elzr/vim-json'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.vim'

" LaTeX
Plug 'lervag/vimtex'

call plug#end()
filetype plugin indent on


"=============================Plug Settings================================="

" deoplete
let g:deoplete#sources#jedi#python_path = expand('~/anaconda3/bin/python')
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#server_timeout = 30


" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" localvimrc
let g:localvimrc_ask = 1
let g:localvimrc_persistent = 2
let g:localvimrc_event = ["VimEnter", "BufNewFile", "BufRead"]

" nerdtree
map <leader>] :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" buffergator
let g:buffergator_supress_keymaps = 1
noremap l; :BuffergatorToggle<CR>

" easymotion
let g:EasyMotion_smartcase = 1
nmap <C-f> <Plug>(easymotion-sn)

" fzf
let g:fzf_layout = { 'down': '~20%' }

" seoul256.vim
let g:seoul256_background = 234

" vim-thematic
let g:thematic#theme_name = 'gruvbox'
let g:thematic#themes = {
            \'srcery-dark': {
            \       'colorscheme': 'srcery-drk',
            \       'background': 'dark',
            \       'airline-theme': 'minimalist',
            \   },
            \'gruvbox': {
            \       'colorscheme': 'gruvbox',
            \       'background': 'dark',
            \       'airline-theme': 'gruvbox',
            \   },
            \'seoul': {
            \       'colorscheme': 'seoul256',
            \       'background': 'dark',
            \       'airline-theme': 'zenburn',
            \   },
            \'wombat': {
            \       'colorscheme': 'wombat256i',
            \       'background': 'dark',
            \       'airline-theme': 'wombat',
            \   },
            \'solarized': {
            \       'colorscheme': 'solarized',
            \       'background': 'dark',
            \       'airline-theme': 'solarized',
            \   },
            \'writing': {
            \       'colorscheme': 'seoul256',
            \       'background': 'dark',
            \       'airline-theme': 'zenburn',
            \   }
            \}
nnoremap <leader>]] :ThematicNext<CR>
nnoremap <leader>[[ :ThematicPrevious<CR>

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

" vim-smooth-scroll
noremap <silent> gk :call smooth_scroll#up(&scroll, 0, 9)<CR>
noremap <silent> gj :call smooth_scroll#down(&scroll, 0, 9)<CR>
noremap <silent> gkk :call smooth_scroll#up(&scroll*2, 0, 9)<CR>
noremap <silent> gjj :call smooth_scroll#down(&scroll*2, 0, 9)<CR>

" vim-wheel
let g:wheel#map#up   = '<M-k>'
let g:wheel#map#down = '<M-j>'

" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

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
let g:syntastic_python_python_exec = expand('~/anaconda3/bin/python') " use python3 syntax
let g:syntastic_python_checkers = ['flake8']                 " use flake8 for python
let g:syntastic_javascript_checkers = ['eslint']             " use eslint for javascript
let g:syntastic_html_tidy_exec = 'tidy'                      " use tidy for html5
let g:syntastic_mode_map = {
            \'mode': 'active',
            \'passive_filetypes': ['haskell']
            \}                                               " disable syntastic for haskell. we use ghc-mod-vim for it.

" Gundo
map <F3> :GundoToggle<CR>

" fugitive
map <F4> :Gdiff<CR>
map <F5> :Gstatus<CR>
map <F6> :Gcommit<CR>
map <F7> :Gpull
map <F8> :Gpush

" vim-emoji
augroup emoji_complete
  autocmd!
  autocmd FileType markdown setlocal omnifunc=emoji#complete
augroup END
nnoremap <leader>m :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" numbers
let g:numbers_exclude = [
            \'unite', 'tagbar', 'startify',
            \'gundo', 'vimshell', 'w3m',
            \'markdown', 'rst'
            \]

" startify
let g:startify_relative_path       = 1
let g:startify_change_to_dir       = 1
let g:startify_change_to_vcs_root  = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
let g:startify_custom_indices = ['s', 'n', 'f', 'r']

" vim-move
let g:move_key_modifier = 'C'

" vim-sneak
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-expand-region
vmap <C-]> <Plug>(expand_region_expand)
vmap <C-[> <Plug>(expand_region_shrink)

" limelight.vim
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_paragraph_span = 2
nnoremap <leader>l :Limelight!!<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" ghc-mod-vim
au FileType haskell nnoremap <buffer> t :GhcModInfo<CR>
au FileType haskell nnoremap <buffer> T :GhcModType<CR>
au FileType haskell nnoremap <buffer> <leader>t :GhcModTypeClear<CR>
au BufReadPost *.hs GhcModCheckAndLintAsync
au BufWritePost *.hs GhcModCheckAndLintAsync

" Jedi-vim
au filetype python let g:jedi#completions_enabled = 0
au filetype python let g:jedi#goto_definitions_command = '<leader>d'
au filetype python let g:jedi#goto_assignments_command = '<leader>g'
au filetype python let g:jedi#usages_command = '<leader>n'
au filetype python let g:jedi#rename_command = '<leader>r'
"au filetype python let g:jedi#popup_on_dot = 1
au filetype python let g:jedi#popup_select_first = 1
"au filetype python let g:jedi#use_splits_not_buffers = "left"
let g:python_host_prog = expand('~/anaconda3/bin/python')
let g:python3_host_prog = expand('~/anaconda3/bin/python')

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

" markdown-preview.vim
let g:mkdp_auto_close = 0
let g:mkdp_command_for_global = 1
au filetype markdown let g:python_host_prog = expand('~/anaconda3/bin/python')

" vim-better-whitespace
autocmd FileType python,javascript,javascript.jsx,html,htmldjango let g:better_whitespace_enabled=1
autocmd FileType python,javascript,javascript.jsx,html,htmldjango let g:strip_whitespace_on_save=1
autocmd FileType python,javascript,javascript.jsx,html,htmldjango let g:strip_whitespace_confirm=0


"============================General Settings================================"

" Add user local bin to runtime path
let $PATH = $PATH . ':' . expand("~/.local/bin")

" Encoding
set enc=utf-8

" Enable alternate input methods
set noimd
set imi=1
set ims=-1

" Enable syntax
syntax on

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

" Set Clipboard
set clipboard=unnamed

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Indentations
set expandtab
set smarttab
set smartindent
set shiftwidth=4
set tabstop=4
filetype indent on

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Completion list maximum length
set ph=20

" Settings for display
set nu
set colorcolumn=80
set bg=dark
autocmd VimEnter,BufReadPost,BufEnter,colorscheme *
            \ highlight ColorColumn ctermbg=red ctermfg=white cterm=bold

" Strip trailing whitespaces
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()


" Key mappings
nnoremap <F9> :tabnew<CR>
nnoremap <F10> :tabclose<CR>
nnoremap gr :tabprevious<CR>
nnoremap - :vertical res -5<CR>
nnoremap = :vertical res +5<CR>
nnoremap _ :res -5<CR>
nnoremap + :res +5<CR>
nnoremap <C-t> :Lines<CR>
nnoremap <C-p> :Files<CR>

" Writing mode
function! ToggleWritingMode()
    if g:in_writing_mode
        let g:in_writing_mode=0
        let g:vim_markdown_folding_disabled=1
        :Thematic writing
        :PencilOff
    else
        let g:in_writing_mode=1
        let g:vim_markdown_folding_disabled=0
        :Thematic writing
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
au FileType python inoremap # X<c-h>#<space>
au FileType bash,sh setl ts=2 sw=2 sts=2
au FileType haskell setl sw=2
au FileType thrift setl ts=2 sw=2 sts=2
au FileType javascript setl ts=2 sw=2 sts=2
au FileType html,htmldjango setl ts=2 sw=2 sts=2
au FileType yaml,yml setl ts=2 sw=2 sts=2 expandtab
au FileType css,scss,sass,less setl ts=2 sw=2 sts=2
