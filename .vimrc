" Use vim settings, rather than Vi settings
set nocompatible

" Vundle plugins install section
" Install with :PluginInstall
" =============================
let has_vundle=1
if !filereadable(expand("~/.vim/bundle/Vundle.vim/README.md"))
    echo "Installing Vundle..."
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
    let has_vundle=0
endif

filetype off " required for Vundle
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " let Vundle manage itself

" color schemes
Plugin 'vim-scripts/wombat256.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rainux/vim-desert-warm-256'
Plugin 'nanotech/jellybeans.vim'

" Filesystem
Plugin 'scrooloose/nerdtree' " filesystem explore (F12)
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kien/ctrlp.vim' " file/buffer fuzzy finder (Ctrl+F)

" Utilities
"Plugin 'Townk/vim-autoclose' " autocomplete open-close pairs, e.g: () {} <> []
"Plugin 'vim-scripts/YankRing.vim' " access to yanked buffer (F3)
Plugin 'ervandew/supertab' " <Tab> everything!
"Plugin 'mhinz/vim-startify' " a start screen for vim!
Plugin 'Lokaltog/vim-easymotion' " Quickly jump to another place (,,w)
Plugin 'jeetsukumaran/vim-buffergator' " list & navigate buffers (,b)

" Git
Plugin 'tpope/vim-fugitive' " :G* git commands
Plugin 'airblade/vim-gitgutter' " show git diff signs in the gutter column

" Visuals
"Plugin 'powerline/powerline'
"Plugin 'bling/vim-airline'
Plugin 'itchyny/lightline.vim' " A light and configurable statusline/tabline

" Code
Plugin 'scrooloose/syntastic' " syntax checker
Plugin 'majutsushi/tagbar' " tags window tree (F8) (definitions/function/etc.)
Plugin 'Valloric/YouCompleteMe' " code completion engine for C-family/Python/etc.
                                " https://github.com/Valloric/YouCompleteMe#installation
Plugin 'Valloric/ListToggle' " easily toggle the quickfix and location-list
"Plugin 'Rip-Rip/clang_complete'

"Plugin 'nvie/vim-flake8'
"Plugin 'davidhalter/jedi-vim'

" check:
" Plugin 'ervandew/supertab'

call vundle#end()

" Install plugins for the first time (then quit)
if has_vundle == 0
    :silent! PluginInstall
    echo "Plugins istalled! Restart vim."
    :qa
endif

" enable filetype detection features
filetype plugin indent on

" set utd-8 as the internal vim encoding
set encoding=utf-8

" Use unix as the standard file type
set fileformats=unix,dos

" Disable swap files - they trigger too many events for file system watchers
" Enable backup - better safe than sorry. Rolled every minute.
set noswapfile
set backup
set writebackup
set backupdir=~/.tmp,~/tmp,~/.vim/backup
autocmd BufWritePre * let &backupext = '-' . strftime("(%Y-%m-%d)-{%H:%M}") . '~'

" use indentation from the previous line
set autoindent

" configure tab handling (spaces instead of tabs, etc.)
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab " Use spaces instead of tabs
set smarttab " smarter tabs

" maximum width of inserted text (80 is too small for modern displays)
set textwidth=100

" compact gvim UI
if has("gui_running")
    set guioptions-=m " remove menubar
    set guioptions-=T " remove toolbar
    set guioptions-=r " remove right scrollbar
    set lines=50
    set columns=100
endif

" highlight group for wrong whitespace, must appear before the colorscheme
autocmd ColorScheme * highlight BadWhitespace ctermbg=red guibg=red

" color scheme
set t_Co=256
colorscheme wombat256mod
"colorscheme jellybeans
"set background=dark
syntax on

" color column margin
set colorcolumn=101
highlight ColorColumn ctermbg=235

" show line numbers
set number

" intelligent c-style comments
set comments=sl:/*,mb:\ *,elx:\ */

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" history/undo settings
set history=1000
set undolevels=1000

" general settings
let mapleader="," " set <leader> to ,
set wildmenu " turn on wild menu
set wildmode=longest:full " TAB acts nicely (auto-complete and show the wildmenu)
set autoread " reload file when changes happen in other editors
set mouse=a " enable mouse support
set bs=indent,eol,start " make backspace behave like normal again
set lazyredraw " do not refresh screen while executing macros
set scrolloff=4 " always show 4 lines at the edge when moving the cursor
set sidescrolloff=7 " always show 7 columns at the edge when moving the cursor
set sidescroll=1 " for fast terminals
set magic " for regular expressions
set clipboard=unnamed " make yank copy to the global system clipboard (works?)
set completeopt=longest,menuone " Improving code completion
set splitbelow " split windows to the bottom (e.g, help)
set splitright " split windows to the right
set title " show window title, when possible (e.g, GVIM)
set ttyfast " improve redrawing smoothness
set showcmd " show the keys being entered in the status line
set tildeop " The tilde command ~ behaves like an operator
set shortmess+=I " disable the startup message of VIM

" tags
set tags+=./tags
set tags+=/usr/include/tags
set tags+=/usr/lib/python2.7/tags
set tags+=tags; " search for tags in all of the parent folders of the current folder
set tags+=./tags; " search for tags in all of the parent folders of the current file

" search settings
set hlsearch " highlight search results
set incsearch " search as you type
set ignorecase " ignore case when searching
set smartcase " ignore ignorecase if the search contains uppercase characters

" auto-format settings
set formatoptions-=t " don't automatically wrap text when typing
set formatoptions+=j " when joining lines, smartly join their comments leader

" highlight bad whitespace matching rules (when leaving insert mode)
autocmd InsertLeave * match BadWhitespace /\t\|\s\+$/

" ignore these files in the wildmenu
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*~
set wildignore+=*.a,*.o,*.so,*.obj,*.pyc
set wildignore+=*.jpg,*.jpeg,*.png,*.pdf
set wildignore+=*.git,*.swp,*.swo
set wildignore+=.git,.hg,.svn " TODO: fugitive fails with Gdiff when enabled?

" enable omni-complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" enable omni-complete on filetypes without omni complete registered functions
"autocmd Filetype *
"            \   if &omnifunc == "" |
"            \       setlocal omnifunc=syntaxcomplete#Complete |
"            \   endif
"Python is handled by python-mode. Alternative:
" autocmd FileType python set omnifunc=pythoncomplete#Complete
"C/C++ is handled by clang-complete. Alternative:
" autocmd FileType c set omnifunc=ccomplete#Complete
" autocmd FileType cpp set omnifunc=omni#cpp#complete#Main
" in case there is a problem with cpp, replace with:
" au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

" Mappings - tabs/windows handling
" ================================
" CTRL+T to open new tabs
noremap <C-T> :tabnew<cr>
" Move between tabs
noremap <silent> <Leader>n <Esc>:tabprevious<CR>
noremap <silent> <Leader>m <Esc>:tabnext<CR>
noremap <silent> <C-Right> <Esc>:tabprevious<CR>
noremap <silent> <C-Left> <Esc>:tabnext<CR>
" Move between windows
noremap <silent> <c-j> <c-w>j
noremap <silent> <c-k> <c-w>k
noremap <silent> <c-l> <c-w>l
noremap <silent> <c-h> <c-w>h
noremap <silent> <c-Up> <c-w><c-w>
noremap <silent> <c-Down> <c-w><s-w>
" Resize windows
noremap <silent> + <c-w>+
noremap <silent> _ <c-w>-
noremap <silent> < <c-w><
noremap <silent> > <c-w>>

" Mappings - various shortcuts
" ============================
" Quick save
noremap <silent> <leader>s <Esc>:update<CR>
" Quick quit
"noremap <silent> <leader>q <Esc>:quit<CR>
" Spell-checking toggle
map <leader>sp :setlocal spell!<cr>
" Disable highlight with <leader><cr>
map <silent> <leader><cr> :noh<cr>
" CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" Indentation of selected text
vnoremap < <gv
vnoremap > >gv
" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk
" Select all
map <leader>a ggVG
" remove all end-of-line whitespaces
map <silent> <leader>w :%s/\s\+$//<cr>
" replace all tabs with spaces
map <leader><tab> :retab<cr>
" Git shortcuts (assuming available git aliases)
map <leader>gf :Git fetch --all<cr>
map <leader>gb :Git b<cr>
map <leader>gs :Gstatus<cr>
map <leader>ga :Gwrite<cr>
map <leader>gl :Git l<cr>
map <leader>gla :Git la<cr>
map <leader>gd :Gdiff<cr>
" Disable formatting when pasting (usually large chunks of code)
set pastetoggle=<F2>



" Workarounds
" ===========

" Can also use CTRL+j/k to move inside omnicomplete
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endi    f
    return a:action
endfunction
inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Automatically close the preview window of omnicomplete - disabled
" (preview does not behave nicely)
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" tmux fix
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    map <Esc>OH <Home>
    map! <Esc>OH <Home>
    map <Esc>OF <End>
    map! <Esc>OF <End>
endif


" Plugins Settings
" ================

" python
" ======
"map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" lightline
" =========
set laststatus=2 " always show the statusline
set timeoutlen=250 " timeout for mapped key
set noshowmode " don't show '-- INSERT --' too
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" syntastic
" =========
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = ' -std=c++11'
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes':
        \ ['c', 'cpp', 'perl', 'python', 'sh'] }

" YouCompleteMe
" =============
let g:ycm_always_populate_location_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" ListToggle
" ==========
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
let g:lt_height = 10

" ctrlp
" =====
let g:ctrlp_reuse_window = 'startify'
let g:ctrlp_clear_cache_on_exit = 0 " don't recalc after restart
let g:ctrlp_show_hidden = 1 " also look for hidden files
let g:ctrlp_open_new_file = 'v' " <C-y> to open in a vertical split
"let g:ctrlp_map = '<c-f>' " <c-p> is reserved for YankRink

" NERDTree
" ========
let NERDTreeShowHidden=1 " show hidden files by default
map <leader>nn :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>
map <silent> <F12> :NERDTreeToggle<cr>
map <silent> <S-F12> :NERDTreeFind<cr>
" closes vim if the only buffer left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" starts nerdtree if no files specified when vim opened (disabled)
"autocmd vimenter * if !argc() | NERDTree | endif

" clang_complete
" ==============
let g:clang_complete_auto=1 " automatically complete after ->, ., ::
let g:clang_complete_copen=0 " open quickfix window on error.
let g:clang_hl_errors=1 " highlight the warnings and errors the same way clang does it.
let g:clang_periodic_quickfix=0 " periodically update the quickfix window. - disabled (clears the make output)
let g:clang_snippets=1 " do some snippets magic after a ( or a , inside function call. Not currently fully working.
let g:clang_snippets_engine="clang_complete" " The snippets engine (clang_complete, snipmate, ultisnips... see the snippets subdirectory).
let g:clang_conceal_snippets=1 " clang_complete will use vim 7.3 conceal feature to hide <# and #> which delimit snippet placeholders.
let g:clang_close_preview=1 " the preview window will be close automatically after a completion.
let g:clang_exec="/usr/bin/clang++" " Name or path of clang executable.
let g:clang_user_options="" " Add this value at the end of the clang command
let g:clang_auto_user_options="path, .clang_complete" " use path for include dirs, use .clang_complete for extra settings
let g:clang_use_library=1 " Use libclang directly
let g:clang_library_path="" " The path to libclang.so
let g:clang_complete_macros=0 " If clang should complete preprocessor macros and constants.
let g:clang_complete_patterns=0 " If clang should complete code patterns, i.e loop constructs etc.
" Update and show the quickfix window
nnoremap <F9> :call g:ClangUpdateQuickFix()<CR>:copen<CR>

" tagbar
" ======
let g:tagbar_autoshowtag=1 " unfold as needed to show a tag
" Open a tagbar window that closes when jumped from
nmap <F8> :TagbarOpenAutoClose<cr>
" Open/Close the tagbar window (but leave it open when jumped from)
nmap <S-F8> :TagbarToggle<cr>

" YankRink
" ========
"map <F3> :YRShow<cr>
"imap <F3> <C-O>:YRShow<cr>

" ======================================================================
" below: stuff that need to be arranged/checked/deleted

" Windows like copy/paste shortcuts (CTRL+X/C/V, etc.) - disabled
"vnoremap <C-X> "+x
"vnoremap <S-Del> "+x
"vnoremap <C-C> "+y
"vnoremap <C-Insert> "+y
"map <C-V> "+gP
"map <S-Insert> "+gP
"cmap <C-V> <C-R>+
"cmap <S-Insert> <C-R>+
"noremap <C-Q> <C-V> " Use CTRL-Q to do what CTRL-V used to do

" easier formatting of paragraphs
"vmap Q gq
"nmap Q gqap

" Fixing the copy & paste madness
" ================================
"vmap <C-y> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
"imap <C-v> <Esc><C-v>a

" ======================================================================
" reload .vimrc when it changed
" because the settings are not reset, I prefer to disable it until I find a better approach
"autocmd! bufwritepost .vimrc source %
"
