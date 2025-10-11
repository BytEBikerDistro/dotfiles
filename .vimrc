" ========================
" === BASIC SETTINGS ===
" ========================
set nocompatible              " Disable compatibility with vi
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set tabstop=4                 " Number of spaces per tab
set shiftwidth=4              " Number of spaces for auto-indent
set expandtab                 " Convert tabs to spaces
set autoindent                " Copy indent from current line
set smartindent               " Smart auto-indentation
set mouse=a                   " Enable mouse support
syntax enable                 " Enable syntax highlighting
filetype plugin indent on     " Enable filetype-specific plugins and indenting
set completeopt=menu,menuone,noselect " Autocompletion menu settings
set cursorline                " Highlight current line
set showmatch                 " Highlight matching parentheses
set ignorecase                " Case-insensitive searching
set smartcase                 " Case-sensitive if uppercase is used
set incsearch                 " Incremental search
set hlsearch                  " Highlight search results
set clipboard=unnamedplus,unnamed " Use system clipboard
set wrap                      " Wrap long lines
set linebreak                 " Break lines at word boundaries
set nolist                    " Disable list mode
set textwidth=0               " Disable automatic line breaking
set wrapmargin=0              " Disable wrap margin
let mapleader = " "           " Set leader key to space
set termguicolors             " Enable true colors for better theme support
set hidden                    " Allow switching buffers without saving
set updatetime=300            " Faster completion updates
set shortmess+=c              " Avoid showing extra messages for completion

" ========================
" === KEY MAPPINGS ===
" ========================
" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle relative line numbers
nnoremap <leader>r :set relativenumber!<CR>

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

" Fuzzy file finding (like VS Code Ctrl+P)
nnoremap <C-p> :Files<CR>

" Integrated terminal (like VS Code)
nnoremap <leader>t :terminal<CR>

" Code navigation (coc.nvim)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Code actions and formatting
nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>f :CocCommand prettier.formatFile<CR>

" Debugging (vimspector)
nmap <leader>dd :VimspectorReset<CR>
nmap <leader>db :call vimspector#ToggleBreakpoint()<CR>
nmap <leader>dc :call vimspector#Continue()<CR>
nmap <leader>ds :call vimspector#StepInto()<CR>
nmap <leader>do :call vimspector#StepOver()<CR>
nmap <leader>dr :call vimspector#RunToCursor()<CR>

" Function to show documentation (like VS Code hover)
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" ========================
" === TERMUX CLIPBOARD ===
" ========================
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

" ========================
" === PLUGINS ===
" ========================
call plug#begin('~/.vim/plugged')
" File explorer
Plug 'preservim/nerdtree'
" Status bar
Plug 'vim-airline/vim-airline'
" Commenting
Plug 'tpope/vim-commentary'
" Auto-pairs
Plug 'jiangmiao/auto-pairs'
" Syntax highlighting
Plug 'sheerun/vim-polyglot'
" Theme
Plug 'sainnhe/sonokai'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Debugging
Plug 'puremourning/vimspector'
call plug#end()

" ========================
" === PLUGIN CONFIG ===
" ========================
" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" coc.nvim
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" fzf.vim
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'

" Theme
colorscheme sonokai
let g:sonokai_style = 'andromeda'
" let g:sonokai_style = 'atlantis'
" let g:sonokai_enable_italic = 1
set background=dark
