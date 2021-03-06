syntax on
set number
set relativenumber
set autoindent
set ignorecase
set smartcase
set nohlsearch
set incsearch
set showmatch
set hidden
set scrolloff=8
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set signcolumn=yes

filetype plugin indent on

let mapleader = " "
set rtp+=/usr/local/opt/fzf

" removes any highlighting
nnoremap <silent> <Leader>l :nohl<CR>

call plug#begin('~/.vim/plugged')
"Plug 'gruvbox-community/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'unblevable/quick-scope'
Plug 'itchyny/lightline.vim'
Plug 'vimwiki/vimwiki'
call plug#end()

"colorscheme gruvbox
colorscheme wal
"set bg=dark
"highlight Normal guibg=none

nnoremap <silent> <Leader>r :Rg<CR>
nnoremap <silent> <Leader>ff :FZF<CR>

source $HOME/.config/nvim/coc.vim

"zt zb zz is cursor at top bottom and center respectively


" quickscope highlight only when pressing f and t 
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" quickscope change colors
highlight QuickScopePrimary guifg='#17ebd6' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#ec80ff' gui=underline ctermfg=81 cterm=underline


"lightline changes colors
let g:lightline = {'colorscheme': 'wal'}

"vimwiki markdown change 
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
