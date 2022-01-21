set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'itchyny/lightline.vim'
" Plugin 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

" Put your non-Plugin stuff after this line
set number
set linebreak
set showbreak=+++
set visualbell
set autoindent
filetype plugin indent on
" disable swap file
set noswapfile
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
imap jj <ESC>
syntax on
colorscheme gruvbox

autocmd vimenter * NERDTree | wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1


" Plugin ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'" 

" Auto close brackets
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap (      ()<left>
inoremap ()     ()
inoremap [      []<left>
inoremap []     []
inoremap "      ""<left>
inoremap ""      ""
inoremap '      ''<left>
inoremap ''      ''

set termencoding=utf-8
set encoding=utf-8

" Cocnvim"
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" use system clipboard
set clipboard+=unnamedplus

" vim-go
" let g:go_highlight_functions = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_doc_window_popup_window = 1


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" indentLine
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" lightline
let g:lightline = {
  \ 'colorscheme': 'jellybeans',
\ }
