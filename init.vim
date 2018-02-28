set autochdir
set background=dark
set clipboard+=unnamedplus
set colorcolumn=+1
set completeopt-=preview
set expandtab
set hidden
set number
set shiftwidth=2
set tabstop=2
set termguicolors
set textwidth=80
set wildmode=list:longest

call plug#begin('~/.local/share/nvim/plugged')
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'iCyMind/NeoSolarized'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
call plug#end()

let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery', '--language-server', '--log-file=/tmp/cq.log'],
    \ }

autocmd FileType cpp setlocal completefunc=LanguageClient#complete

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/home/mburakov/.config/nvim/settings.json'
let g:airline_powerline_fonts = 1
let mapleader = ' '

colorscheme NeoSolarized

function CloseSplit()
  let buf = bufnr('%')
  :bn
  exe 'bd!' . buf
endfunction
command CloseSplit :call CloseSplit()

imap ( ()<LEFT>
imap <S-TAB> <C-V><TAB>
imap <TAB> <C-X><C-U>
imap [ []<LEFT>
imap { {}<LEFT>
nmap <S-TAB> :bp<CR>
nmap <TAB> :bn<CR>
nmap <leader><BACKSPACE> :CloseSplit<CR>
nmap <leader>. :call LanguageClient_textDocument_definition()<CR>
nmap <leader>/ :call LanguageClient_textDocument_hover()<CR>
nmap <leader><DOWN> <C-W><DOWN>
nmap <leader><LEFT> <C-W><LEFT>
nmap <leader><RIGHT> <C-W><RIGHT>
nmap <leader><UP> <C-W><UP>
nmap <leader><leader> :noh<CR>
tmap <ESC> <C-\><C-N>
