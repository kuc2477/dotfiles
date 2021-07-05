"NOT COMPATIBLE TO LEGACY VI VERSIONS
set nocompatible


let g:plug_timeout = 300
let s:osname = substitute(system('uname'), "\n", "", "")
let s:username = substitute(system('whoami'), "\n", "", "")

"============================Plug List======================================"

filetype off
call plug#begin('~/.vim/plugged')

" Autocompletions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ervandew/supertab'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Coworking
Plug 'embear/vim-localvimrc'

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
Plug 'majutsushi/tagbar'

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
"Plug 'davidhalter/jedi-vim',         { 'do': 'pip install jedi' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'kuc2477/vim-cute-python',      { 'for': 'python' }
Plug 'vim-scripts/django.vim'

" Javascript / JSX
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'heavenshell/vim-jsdoc'

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

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" localvimrc
let g:localvimrc_ask = 1
let g:localvimrc_persistent = 2
let g:localvimrc_event = ["VimEnter", "BufNewFile", "BufRead"]

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

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

" Tagbar
let g:tagbar_autofocus = 1
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


"==============================CoC Settings================================="

let g:coc_global_extensions = [
            \'coc-python',
            \'coc-json', 'coc-yaml',
            \'coc-html', 'coc-git',
            \]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[[` and `]]` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <c-[> <Plug>(coc-diagnostic-prev)
nmap <silent> <c-]> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
nnoremap - :vertical res -5<CR>
nnoremap = :vertical res +5<CR>
nnoremap _ :res -5<CR>
nnoremap + :res +5<CR>
nnoremap <C-t> :Lines<CR>
nnoremap <C-p> :Files ~<CR>

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

" Hide unwritten buffers
set hidden

"==========================Language Shim Settings============================="

" Javascript
au FileType javascript let g:jsdoc_default_mapping = 1
au FileType javascript noremap <C-e> :JsDoc<CR>
au FileType javascript nnoremap ]] /\(function\s*(.*)\s*{\\|=>\s*{\)<CR>
au FileType javascript nnoremap [[ ?\(function\s*(.*)\s*{\\|=>\s*{\)<CR>

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
