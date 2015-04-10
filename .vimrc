" Vundle stuff
set nocompatible 
filetype off
 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Vundle plugin list
Plugin 'Valloric/YouCompleteMe'

" Initialize plugins
call vundle#end()

filetype plugin indent on
filetype plugin on
 
" End Vundle stuff

colorscheme Tomorrow-Night
syntax on

function ToggleSyntax ()
    :if exists("g:syntax_on") | syntax off | else | syntax on | endif
endfunction

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <F3> :call ToggleSyntax() <CR>
nnoremap <F6> :w<CR>:!git add %<CR>
nnoremap <F7> :!git commit<CR>
nnoremap <F8> :!git push<CR>

nnoremap tn :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap ts :call ToggleSyntax() <CR>
nnoremap ga :w<CR>:!git add %<CR>
nnoremap gc :!git commit<CR>
nnoremap gp :!git push<CR>

" Generic code function. Set width, tabstop, smarttab, numbering
function SetCode ()
    setlocal textwidth=80
    
    setlocal tabstop=6
    setlocal softtabstop=6
    setlocal shiftwidth=6

    setlocal smarttab
    setlocal number
endfunction

" Specific functions for filetypes. Most filetypes use vanilla 
" SetCode(). The most common deviation is to override SetCode()
" with expandtab and custom tab width (Ruby and Python)
function SetGitCommit ()
    call SetCode()
endfunction

function SetRuby ()
    call SetCode()

    setlocal expandtab

    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endfunction

function SetHTML ()
    call SetCode()
endfunction

function SetPython ()
    call SetCode()

    setlocal expandtab

    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
endfunction

" Don't delete this. It's important
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Call setup functions for appropriate filetypes
autocmd FileType gitcommit call SetPython()

autocmd FileType python call SetPython()

autocmd FileType ruby call SetRuby()

autocmd FileType h call SetCode()
autocmd FileType c call SetCode()

autocmd FileType json call SetHTML()
autocmd FileType html call SetHTML()
autocmd FileType javascript call SetHTML()

" Set shell to bash so some one-liners work
set shell=/bin/bash
