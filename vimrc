
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --ts-completer --go-completer
  endif
endfunction

set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'KeitaNakamura/neodark.vim'
Plug 'trusktr/seti.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

Plug 'yegappan/greplace'

Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM')}
Plug 'scrooloose/syntastic'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'majutsushi/tagbar'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'AndrewRadev/switch.vim'
Plug 'mbbill/undotree'
Plug 'Shougo/neoyank.vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'vitaly/vim-gitignore'
Plug 'ludovicchabant/vim-gutentags'
Plug 'christoomey/vim-tmux-navigator'

Plug 'fatih/vim-go'
Plug 'mattn/emmet-vim'

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'mmalecki/vim-node.js'

Plug 'elzr/vim-json'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-markdown'

Plug 'vim-ruby/vim-ruby'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rake'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vim-scripts/blockle.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'vim-scripts/apidock.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'stefanoverna/vim-i18n'

Plug 'epeli/slimux'

call plug#end()

" General Config

scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8
set autoread
set backspace=indent,eol,start
set cursorline
"set ruler                   " show the ruler
"set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set hidden
set history=1000
" set laststatus=2
" set statusline=%<%f\    " Filename
" set statusline+=%w%h%m%r " Options
" set statusline+=\ [%{&ff}/%Y]            " filetype
" set statusline+=\ [%{getcwd()}]          " current dir
" set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
set lazyredraw
set number
set showcmd
set showmatch
set showmode
set title
set ttyfast
set visualbell
set t_vb=
set nowrap
set noesckeys
set formatoptions-=or
runtime macros/matchit.vim
set rtp+=/home/rciatti/.fzf
set maxmempattern=3000

" Leader

let mapleader = ","
let maplocalleader = "\\"

" Search Settings

set incsearch
set hlsearch
set ignorecase
set smartcase

" Persistent undo and backups

silent !mkdir -p ~/.vim/tmp/undo > /dev/null 2>&1
silent !mkdir -p ~/.vim/tmp/backup > /dev/null 2>&1
silent !mkdir -p ~/.vim/tmp/swap > /dev/null 2>&1

if version >= 703
  set undodir=~/.vim/tmp/undo
  set undoreload=10000
  set undofile
endif

set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set backup

" Indentation

set autoindent
set smarttab
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2
set matchpairs+=<:>
set pastetoggle=<F12>
set expandtab
set shiftround
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4

set list listchars=tab:»·,trail:·

" Completion

set wildmode=list:longest,full
set wildmenu

" Colors

syntax enable
set background=dark
" colorscheme solarized
" colorscheme neodark
try
  colorscheme neodark
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

" Scrolling

set scrolloff=8
set sidescrolloff=15
set sidescroll=1

"" Convenience mappings

" Indentation

map <leader>i mmgg=G`m

" Simple save

map <C-s> <Esc>:wa<CR>
imap <C-s> <Esc>:wa<CR>

" Make capitals behave

nnoremap D d$
nnoremap Y y$
command! Q q
command! Qa qa
command! W w
command! Wa wa

" Move on displayed lines

noremap j gj
noremap k gk

" Easy buffer navigation

noremap <C-h>     <C-w>h
noremap <C-j>     <C-w>j
noremap <C-k>     <C-w>k
noremap <C-l>     <C-w>l
noremap <leader>v <C-w>v

" Easy tab navigation

map <S-H> gT
map <S-L> gt

" Substitute

nnoremap <leader>s :%s//<left>

" Clear search highlighting

map <C-l> :nohlsearch<CR>

" Disable help key

noremap  <F1> <NOP>
inoremap <F1> <NOP>

" Disable arrow keys

inoremap  <Up>     <NOP>
noremap   <Up>     <NOP>
inoremap  <Down>   <NOP>
noremap   <Down>   <NOP>
inoremap  <Left>   <NOP>
noremap   <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Right>  <NOP>
noremap   <Right>  <NOP>

" Disable useless stuff

map Q <NOP>
map K <NOP>

" Change Working Directory to that of the current file

cmap cwd lcd %:p:h

" Visual shifting (does not exit Visual mode)

vnoremap < <gv
vnoremap > >gv

" Quickly edit/reload the vimrc file

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Save as root even if not root

cmap w!! %!sudo tee > /dev/null %

" Tags

"set tags=.git/tags,./tags,~/.vim/tags,~/.tags


" Paste

map <Leader>p :set paste<CR><esc>"*]p:set nopaste<cr>

" ,g for Ggrep
nmap <leader>g :silent Ggrep<space>

" ,f for global git serach for word under the cursor (with highlight)
nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>

" same in visual mode
vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>


"" Plugins settings

" Airline

let g:airline_theme='neodark'
" let g:airline_solarized_bg='light'
let g:airline_powerline_fonts = 1
set noshowmode
" ------------------

" YCM
let g:ycm_auto_trigger=0
let g:ycm_key_list_select_completion=['<TAB>', '<Down>']
let g:ycm_add_preview_to_completeopt=1
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_key_list_select_completion=['<C-n>', '<C-j>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<C-k>', '<Up>']
" ------------------

" IndentLine

" let g:indentLine_setColors=0
" let g:indentLine_color_term=239
" let g:indentLine_bgcolor_term='#FFFFFF'
" ------------------

" NERD Tree

map <leader>n :NERDTreeTabsToggle<CR>
map <leader>f :NERDTreeFind<CR>

let g:NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeChDirMode=2
let g:NERDTreeWinSize=40
let g:NERDTreeDirArrows = 1
"let g:NERDTreeDirArrowExpandable=''
"let g:NERDTreeDirArrowCollapsible=''
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeLimitedSyntax = 1

autocmd FileType nerdtree setlocal nolist
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
" ------------------

" NERDCommenter
" ,/ to invert comment on the current line/selection
nmap <leader>/ :call NERDComment(0, "invert")<cr>
vmap <leader>/ :call NERDComment(0, "invert")<cr>
" ------------------

" Vim-Session
let g:webdevicons_enable=1
let g:webdevicons_enable_nerdtree=1
let g:webdevicons_enable_airline_tabline=1
let g:webdevicons_enable_airline_statusline=1
let g:webdevicons_enable_ctrlp=1
let g:WebDevIconsNerdTreeGitPluginForceVAlign=1
let g:WebDevIconsOS = 'Linux'
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif
" ------------------

" Vim DevIcons
let g:session_autosave='no'
let g:session_autoload='no'

nmap <leader>SS :SaveSession
nmap <leader>SO :OpenSession
if has('gui_running')
  nmap <leader>SR :RestartVim<CR>
endif
" ------------------

" switch
autocmd FileType haml let b:switch_definitions =
     \ [
     \   g:switch_builtins.ruby_hash_style,
     \   g:switch_builtins.ruby_string,
     \   g:switch_builtins.true_false,
     \   g:switch_builtins.true_false,
     \ ]

nnoremap ` :Switch<cr>
" ------------------

" UndoTree
nmap <leader>u :UndotreeToggle<CR>
"let g:undotree_SetFocusWhenToggle=1
let g:undotree_WindowLayout = 3
" ------------------

" ack and grep

map <leader>a :Ack!<space>
let g:ackprg = 'rg --vimgrep'
set grepprg=rg\ --vimgrep

" CtrlP
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_max_height=20
let g:ctrlp_switch_buffer=0
let g:ctrlp_user_command = {
  \ 'types': {
          \ 1: ['.git', 'cd %s && git ls-files --exclude-standard -cod | grep -viE "\.(png|gif|jpg|gz|woff|eot|tiff|ttf|otf)$"'],
          \ },
  \ 'fallback': 'rg %s --files --vimgrep --glob ""'
  \ }
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'mixed', 'line']
let g:ctrlp_open_multiple_files='hjr'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_custom_ignore = {'dir': 'vendor/bundler$\|\.git$\|\.hg$\|\.svn$', 'file': '\.exe$\|\.so$\|\.dll$' }
"let g:ctrlp_prompt_mappings = {
         "\ 'AcceptSelection("e")': ['<c-t>'],
         "\ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
         "\ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
         "\ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>']
         "\ }

let g:ctrlp_map=''
"map <C-t> :CtrlPTag<CR>
" ------------------

" Tagbar
nmap <leader>O :TagbarToggle<cr>
" ------------------

" FZF
if executable("ag") && ('' == $FZF_DEFAULT_COMMAND)
  let $FZF_DEFAULT_COMMAND = "ag --follow --nocolor --nogroup -g ''"
endif

nmap <leader>, :Files<cr>
nmap <leader>k :Ag<cr>
nmap <leader>l :Lines<cr>
nmap <leader>t :Tags<cr>
nmap <localleader>t :BTags<cr>
" ------------------

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
" ------------------

" Syntastic

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
" ------------------

" Blockle
let g:blockle_mapping = '<Leader>B'
" ------------------

" Vim Rspec
map <Leader>r :call RunNearestSpec()<CR>
" ------------------

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
