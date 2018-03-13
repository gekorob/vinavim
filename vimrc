set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'trusktr/seti.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-markdown'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-ruby/vim-ruby'
Plugin 'epeli/slimux'
Plugin 'kien/rainbow_parentheses.vim'

call vundle#end()
filetype plugin indent on

" General Config

scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8
set autoread
set backspace=indent,eol,start
set cursorline
set ruler                   " show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set showcmd
set hidden
set history=1000
set laststatus=2
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
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

filetype plugin indent on
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
colorscheme seti

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

set tags=.git/tags,./tags,~/.vim/tags,~/.tags

" Paste

map <Leader>p :set paste<CR><esc>"*]p:set nopaste<cr>

"" Plugins settings

" NERD Tree

map <C-e> :NERDTreeToggle<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

let g:NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 40
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

autocmd FileType *
      \ if &omnifunc != '' |
      \   silent! all SuperTabChain(&omnifunc, "<c-p>") |
      \   silent! all SuperTabSetDefaultCompletionType("<c-x><c-u>") |
      \ endif

" ack and grep

map <leader>a :Ack!<space>
let g:ackprg = 'rg --vimgrep'
set grepprg=rg\ --vimgrep

" CtrlP

let g:ctrlp_user_command = 'rg %s --files --vimgrep --glob ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_custom_ignore = {'dir': 'vendor/bundler$\|\.git$\|\.hg$\|\.svn$', 'file': '\.exe$\|\.so$\|\.dll$' }
let g:ctrlp_prompt_mappings = {
         \ 'AcceptSelection("e")': ['<c-t>'],
         \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
         \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
         \ 'AcceptSelection("v")': ['<c-v>', '<RightMouse>']
         \ }

map <C-t> :CtrlPTag<CR>

" Syntastic

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
let g:syntastic_javascript_checkers = ['eslint']

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Powerline

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

set laststatus=2
set noshowmode
