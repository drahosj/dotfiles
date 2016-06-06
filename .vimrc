" Vim-plug
call plug#begin('~/.vim/plugged')

" Enable plugins
" YCM is deferred
Plug 'Valloric/YouCompleteMe', { 'on': [] }

" End plug
call plug#end()

" YCM Configuration
let g:ycm_global_ycm_extra_conf = '/home/jake/.ycm_extra_conf_global.py'
source ~/.ycm_extra_conf_globlist

" Completion enabler
command -bar StartCompletion call StartCompletion()
function StartCompletion()
    call plug#load('YouCompleteMe')
    call youcompleteme#Enable()
endfunction

" YCM Start Conditions
autocmd FileType c call StartCompletion()
autocmd FileType h call StartCompletion()
autocmd FileType cpp call StartCompletion()
autocmd FileType ruby call StartCompletion()
autocmd FileType python call StartCompletion()

" Start YCM if there is a .ycm_extra_conf.py
if filereadable('./.ycm_extra_conf.py')
    call StartCompletion()
endif
 
" Other configuration
filetype plugin indent on
 
colorscheme Tomorrow-Night
syntax on

function ToggleSyntax()
    :if exists("g:syntax_on") | syntax off | else | syntax on | endif
endfunction

nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap <F3> :call ToggleSyntax() <CR>
nnoremap <F6> :w<CR>:!git add %<CR>
nnoremap <F7> :!git commit<CR>
nnoremap <F8> :!git push<CR>

nnoremap tn :set nonumber!<CR>:set foldcolumn=0<CR>
nnoremap ts :call ToggleSyntax() <CR>
nnoremap tt :NERDTreeToggle<CR>
nnoremap th :Hexmode<CR>
nnoremap tp :set invpaste paste?<CR>

nnoremap ga :w<CR>:!git add %<CR>
nnoremap gc :!git commit<CR>
nnoremap gp :!git push<CR>

" Numbers by default
set number
set foldcolumn=0

" Hexmode stuff
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" Generic code function. Set width, tabstop, smarttab, numbering
function SetCode ()
    setlocal textwidth=80
    
    setlocal smarttab
    setlocal number
endfunction

function SetTab(width)
    let &l:tabstop = a:width
    let &l:shiftwidth = a:width

    call SetCode()
endfunction

function SetSpace(width)
    call SetTab(a:width)

    let &l:softtabstop = a:width
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

autocmd FileType yaml call SetSpace(4)

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
