" Vundle stuff
set nocompatible 
filetype off
 
filetype plugin indent on
filetype plugin on
 
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
nnoremap tt :NERDTreeToggle<CR>

" Generic code function. Set width, tabstop, smarttab, numbering
function SetCode ()
    setlocal textwidth=80
    
    setlocal smarttab
    setlocal number
endfunction

function SetTab(width)
    let &l:tabstop = a:width
    let &l:softtabstop = a:width
    let &l:shiftwidth = a:width

    call SetCode()
endfunction

function SetSpace(width)
    call SetTab(a:width)

    setlocal expandtab

    call SetCode()
endfunction
    

" Specific functions for filetypes. Most filetypes use vanilla 
" SetCode(). The most common deviation is to override SetCode()
" with expandtab and custom tab width (Ruby and Python)
function SetGitCommit ()
    call SetCode()
endfunction

" Don't delete this. It's important
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Call setup functions for appropriate filetypes
autocmd FileType gitcommit call SetSpace(4)

autocmd FileType python call SetSpace(4)

autocmd FileType ruby call SetSpace(2)

autocmd FileType h call SetTab(4)
autocmd FileType c call SetTab(6)
autocmd FileType cpp call SetTab(4)

autocmd FileType vhd call SetTab(8)
autocmd FileType vhdl call SetTab(8)

autocmd FileType json call SetSpace(4)
autocmd FileType html call SetSpace(4)
autocmd FileType javascript call SetSpace(4)

" Set shell to bash so some one-liners work
set shell=/bin/bash

" Auto NerdTree if no file given
function! StartUp()
	if 0 == argc()
		vsplit
		NERDTree
	end
endfunction

autocmd VimEnter * call StartUp()

" Splits Keybindings and stuff
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

command! -nargs=1 SS call SetSpace(<f-args>)
command! -nargs=1 ST call SetTab(<f-args>)
