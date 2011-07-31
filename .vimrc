set encoding=utf-8

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" General option
" ===============
syntax on
filetype plugin indent on
set mouse=a

set autoread
set nobackup
set noswapfile

set history=700
set undolevels=700

set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround 
set expandtab
set pastetoggle=<F2> " disable formatting when pasting large chunks of code

set hlsearch
set incsearch
set ignorecase
set smartcase

set nowrap " don't automatically wrap on load
set tw=79  " width of document (used by gd)
set fo-=t  " don't automatically wrap text when typing
set number " show line numbers

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Custom mappings
" ================
map <Leader>r <esc>:so /home/martin/.vimrc<CR>
map <Leader>[ <esc>:tabprevious<CR>
map <Leader>] <esc>:tabnext<CR>
vnoremap <Leader>m "+y
vnoremap <Leader>s :sort<CR>

" Show trailing whitespace
" =========================
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" =============
color wombat256mod

set colorcolumn=80
highlight ColorColumn ctermbg=233
