" general settings
set number
syntax enable
set cursorline
set title

map <C-a> <ESC>^
imap <C-a> <ESC>I

" use spaces everywhere
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" filetype detection + plugin + indent scripts
filetype plugin indent on

" YAML-specific indent
augroup yaml_indent
  autocmd!
  autocmd FileType yaml setlocal expandtab
  autocmd FileType yaml setlocal tabstop=2
  autocmd FileType yaml setlocal shiftwidth=2
  autocmd FileType yaml setlocal softtabstop=2
  autocmd FileType yaml setlocal indentexpr=
  autocmd FileType yaml setlocal autoindent
  autocmd FileType yaml setlocal nocindent
  autocmd FileType yaml setlocal nosmartindent
augroup END