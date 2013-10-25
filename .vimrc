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

function SetCode ()
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
    setlocal textwidth=80
    setlocal smarttab
    setlocal expandtab
    setlocal number
endfunction

function SetGitCommit ()
    call SetCode()
endfunction

function SetRuby ()
    call SetCode()

    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endfunction

function SetHTML ()
    call SetCode()

    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endfunction

function SetPython ()
    call SetCode()
endfunction

au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

autocmd FileType python call SetPython()
autocmd FileType ruby call SetRuby()
autocmd FileType gitcommit call SetPython()
autocmd FileType c call SetCode()
autocmd FileType json call SetHTML()
autocmd FileType html call SetHTML()
autocmd FileType javascript call SetHTML()
