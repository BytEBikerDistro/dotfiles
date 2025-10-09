" ========================
" === BASIC SETTINGS ===
" ========================
set nocompatible              " Disable compatibility with vi
set number                    " Show line numbers
set tabstop=4                 " Number of spaces per tab
set shiftwidth=4              " Number of spaces for auto-indent
set expandtab                 " Convert tabs to spaces
set autoindent                " Copy indent from current line
set smartindent               " Smart auto-indentation
set mouse=a                   " Enable mouse support
syntax enable                 " Enable syntax highlighting
filetype plugin on            " Enable filetype-specific plugins
set completeopt=menu,preview  " Autocompletion menu with preview
set cursorline                " Highlight current line
set showmatch                 " Highlight matching parentheses
set ignorecase                " Case-insensitive searching
set smartcase                 " Case-sensitive if uppercase is used
set incsearch                 " Incremental search
set hlsearch                  " Highlight search results
set clipboard=unnamedplus,unnamed " Use both system clipboard and primary selection
set wrap                      " Wrap long lines
set linebreak                 " Break lines at word boundaries
set nolist                    " Disable list mode
set textwidth=0               " Disable automatic line breaking
set wrapmargin=0              " Disable wrap margin
let mapleader = " "           " Set leader key to space

" ========================
" === KEY MAPPINGS ===
" ========================
" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlights
nnoremap <leader>c :nohlsearch<CR>

" Toggle commenting
nnoremap <leader>/ :Commentary<CR>

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Buffer management
nnoremap <leader>bn :enew<CR>        " Open new empty buffer
nnoremap <leader>bl :bnext<CR>       " Switch to next buffer
nnoremap <leader>bh :bprevious<CR>   " Switch to previous buffer
nnoremap <leader>bd :bdelete<CR>     " Delete current buffer

" Window split management
nnoremap <leader>sv :vsplit<CR>      " Vertical split
nnoremap <leader>sh :split<CR>       " Horizontal split
nnoremap <leader>sc :close<CR>       " Close current window
nnoremap <leader>so :only<CR>        " Close all other windows

" Tab management
nnoremap <leader>tn :tabnew<CR>      " Open new tab
nnoremap <leader>tc :tabclose<CR>    " Close current tab
nnoremap <leader>tl :tabnext<CR>     " Switch to next tab
nnoremap <leader>th :tabprevious<CR> " Switch to previous tab
nnoremap <leader>t1 :tabn 1<CR>      " Go to tab 1
nnoremap <leader>t2 :tabn 2<CR>      " Go to tab 2
nnoremap <leader>t3 :tabn 3<CR>      " Go to tab 3
nnoremap <leader>t4 :tabn 4<CR>      " Go to tab 4

" Swap ; and : for easier command entry
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" ========================
" === TERMUX CLIPBOARD ===
" ========================
" Use system clipboard if available (desktop/GUI Vim).
" In Termux, add extra mappings for Android clipboard.
if executable('termux-clipboard-set')
  " Copy selection to Android clipboard
  vnoremap <leader>y :w !termux-clipboard-set<CR><CR>
  " Paste from Android clipboard
  nnoremap <leader>p :r !termux-clipboard-get<CR>
endif

" ========================
" === VIM-PLUG AUTOLOAD ===
" ========================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tomasr/molokai'
Plug 'ayu-theme/ayu-vim'
Plug 'rakr/vim-one'
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'arcticicestudio/nord-vim'
" File explorer
Plug 'preservim/nerdtree'
" Status bar
Plug 'vim-airline/vim-airline'
" Commenting
Plug 'tpope/vim-commentary'
" Auto-pairs
Plug 'jiangmiao/auto-pairs'
call plug#end()

" ========================
" === AIRLINE CONFIG ===
" ========================
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" ========================
" === THEME CHOOSER ===
" ========================
let g:themes = [
  \ {'name': 'gruvbox', 'airline': 'gruvbox'},
  \ {'name': 'onedark', 'airline': 'onedark'},
  \ {'name': 'dracula', 'airline': 'dracula'},
  \ {'name': 'molokai', 'airline': 'molokai'},
  \ {'name': 'ayu', 'airline': 'ayu'},
  \ {'name': 'one', 'airline': 'one'},
  \ {'name': 'everforest', 'airline': 'everforest'},
  \ {'name': 'sonokai', 'airline': 'sonokai'},
  \ {'name': 'nord', 'airline': 'nord'}
  \ ]

let s:theme_file = expand('~/.vim_last_theme')
if filereadable(s:theme_file)
  let g:current_theme_index = str2nr(readfile(s:theme_file)[0])
else
  let g:current_theme_index = 0
endif

function! SetTheme(idx)
  if a:idx >= 0 && a:idx < len(g:themes)
    let theme = g:themes[a:idx]
    try
      execute 'colorscheme ' . theme.name
      let g:airline_theme = theme.airline
      set background=dark
      call writefile([string(a:idx)], s:theme_file)
      if has("vim_starting") == 0
        echo "Switched to theme: " . theme.name
      endif
    catch /^Vim\%((\a\+)\)\=:E185/
      echohl ErrorMsg | echom "Theme '".theme.name."' not found! Run :PlugInstall" | echohl None
    endtry
  endif
endfunction

function! CycleTheme(direction)
  let g:current_theme_index = (g:current_theme_index + a:direction + len(g:themes)) % len(g:themes)
  call SetTheme(g:current_theme_index)
endfunction

nnoremap <leader><Right> :call CycleTheme(1)<CR>
nnoremap <leader><Left>  :call CycleTheme(-1)<CR>
call SetTheme(g:current_theme_index)


