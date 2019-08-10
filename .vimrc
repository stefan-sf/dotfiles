source ~/.vim/vundle.vim

autocmd FileType c setlocal commentstring=//\ %s

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata:h12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif

  set guicursor+=a:blinkon0
  set lines=40 columns=170

  set guioptions+=m  "menu bar
  set guioptions-=T  "toolbar
endif

" set encoding to unicode default is laten1
set encoding=utf-8

" sets the character encoding for the file of this buffer
set fileencoding=utf-8

" show matching braces
set showmatch

" highlighting the most-recently-found search text
set hls

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

set number
set cursorline
set cursorcolumn

set mouse=a

set backspace=indent,eol,start

"
set nostartofline

set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
set titleold=Terminal
set title

set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set viminfofile=~/.vim/viminfo

" set list
" set listchars=tab:▸\ "

" persistent undo
set undofile

set hidden " allows switching to another buffer with unsaved buffer open

set foldmethod=syntax
" set foldmethod=indent
set foldlevel=99
set foldcolumn=2
let g:xml_syntax_folding=1
let javaScript_fold=1

let g:asyncomplete_remove_duplicates=1
" let g:asyncomplete_smart_completion=1
let g:asyncomplete_auto_popup=0

" the register "* is for X11 PRIMARY selection while
" the register "+ is for X11 CLIPBOARD selection
" paste via <C-r><C-p>* or +
vnoremap <C-c> "+y
" inoremap <C-v> <Esc>"+p

vnoremap * y/<C-R>"<CR>

set clipboard+=unnamed


" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap <C-h> :LspHover<CR>


" move cursor by display lines not lines defined by carriage return
" noremap <silent> <Leader>w :call ToggleWrapLines()<CR>
let w:toggleWrapLines = 0
" function ToggleWrapLines()
"    if w:toggleWrapLines == 1
"       :noremap <Up> k
"       :noremap! <Up> <C-O>k
"       :noremap <Down> j
"       :noremap! <Down> <C-O>j
"       let w:toggleWrapLines = 0
"    else
"       :noremap <Up> gk
"       :noremap! <Up> <C-O>gk
"       :noremap <Down> gj
"       :noremap! <Down> <C-O>gj
"       let w:toggleWrapLines = 1
"    endif
" endfunction
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if w:toggleWrapLines == 1
    echo "Wrap OFF"
    " setlocal nowrap
    " set virtualedit=all
    silent! nunmap <buffer> k
    silent! nunmap <buffer> j
    silent! nunmap <buffer> 0
    silent! nunmap <buffer> $
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
    let w:toggleWrapLines = 0
  else
    echo "Wrap ON"
    " setlocal wrap
    " setlocal wrap linebreak nolist
    " set virtualedit=
    " setlocal display+=lastline
    noremap  <buffer> <silent> k gk
    noremap  <buffer> <silent> j gj
    noremap  <buffer> <silent> 0 g0
    noremap  <buffer> <silent> $ g$
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
    let w:toggleWrapLines = 1
  endif
endfunction

" redefine the command :mak to :make!
" command Make make!
cabbrev mak <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'make!' : 'mak')<CR>

" restore cursor to file position in previous editing session
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

filetype plugin indent on
autocmd FileType tex setlocal autoindent nocindent nosmartindent indentexpr=
set pastetoggle=<F2>

" toggle highlighting the most-recently-found search text
nnoremap \th :set invhls hls?<CR>
nmap <F3> \th
imap <F3> <C-O>\th

let g:solarized_contrast="high"    " default value is normal
let g:solarized_visibility="high"  " default value is normal
let g:solarized_diffmode="high"    " default value is normal
let g:solarized_bold=1             " 1|0 show bold fonts
let g:solarized_underline=1        " 1|0 show underlines
syntax on
set background=dark
colorscheme solarized


" ervandew/supertab
let g:SuperTabMappingForward = '<c-n>'
let g:SuperTabDefaultCompletionType = "context"


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "❌"
let g:syntastic_style_warning_symbol = "⚠️ "
"let g:syntastic_auto_jump = 2
let g:syntastic_ocaml_checkers = ['merlin']

au FileType ocaml nnoremap <localleader>l :Locate<cr>
"function! SetupOCaml()
"  nnoremap <leader>t :TypeOf<cr> " default is ll-t
"  vnoremap <leader>t :TypeOfSel<cr> " default is ll-t
"  nnoremap <leader>f :Locate<cr>
"  nnoremap <leader>d :Destruct<cr>
"  nmap <leader>n <Plug>(MerlinSearchOccurrencesForward)
"  nmap <leader>N <Plug>(MerlinSearchOccurrencesBackward)
"  nmap <leader>r <Plug>(MerlinRename)
"  nmap <leader>R <Plug>(MerlinRenameAppend)
"  call SuperTabSetDefaultCompletionType("<c-x><c-o>")
"endfunction
"
"au FileType ocaml call SetupOCaml()

" TeX class files
autocmd BufNewFile,BufRead *.cls set syntax=tex

" this needs to be at the end since it's (re)set when compatible is (re)set
autocmd BufNewFile,BufRead * setlocal formatoptions-=o " disable comment continuation for o/O (use enter)

hi SyntasticErrorSign term=bold cterm=bold ctermfg=1 ctermbg=0 guifg=White guibg=Red
hi SyntasticWarningSign ctermbg=0

let w:toggleFold = 0
function ToggleFold()
  let l:curr = &foldcolumn
  let &foldcolumn = w:toggleFold
  let w:toggleFold = l:curr
endfunction

let mapleader = ","
nnoremap <leader>c :w<CR>:Dispatch<CR>
nnoremap <leader>d :w<CR>:Dispatch!<CR>
nnoremap <leader>s :w<CR>
autocmd FileType rust let b:dispatch = 'cargo build'
" autocmd FileType rust autocmd BufWritePost * :Dispatch
nnoremap <leader>t :set number!<CR>:call ToggleFold()<CR>

" Enable folding with the spacebar
nnoremap <space> za

" insert a 'tab' regardless of expandtab
inoremap <s-tab> <c-v><tab>

inoremap <C-c> <Esc>


if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
    autocmd FileType c setlocal omnifunc=lsp#complete
    autocmd FileType cpp setlocal omnifunc=lsp#complete
    autocmd FileType objc setlocal omnifunc=lsp#complete
    autocmd FileType objcpp setlocal omnifunc=lsp#complete
    autocmd FileType c nmap gd <plug>(lsp-definition)
    autocmd FileType cpp nmap gd <plug>(lsp-definition)
endif
