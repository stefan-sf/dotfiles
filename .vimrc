set nocompatible

autocmd FileType c setlocal commentstring=//\ %s

if has("gui_running")
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

set spelllang=en_us
function! SetSpell()
  set spell
  hi SpellBad cterm=underline ctermfg=red
  hi SpellBad gui=undercurl guifg=red
endfunction
function! UnsetSpell()
  set spell&
  hi clear SpellBad
endfunction

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#skip_indent_check_ft =
      \ {'cpp': ['indent', 'mixed-indent-file']}

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

" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ asyncomplete#force_refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap <C-h> :LspHover<CR>


" move cursor by display lines not lines defined by carriage return
" noremap <silent> <Leader>w :call ToggleWrapLines()<CR>
let w:toggleWrapLines = 0
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

let g:solarized_contrast="high"    " default value is normal
let g:solarized_visibility="high"  " default value is normal
let g:solarized_diffmode="high"    " default value is normal
let g:solarized_bold=1             " 1|0 show bold fonts
let g:solarized_underline=1        " 1|0 show underlines
syntax on
set background=dark
colorscheme solarized
" fix gitgutter https://github.com/airblade/vim-gitgutter/issues/696
highlight! link SignColumn LineNr


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

autocmd BufNewFile,BufRead */gcc/config/*/*.md set filetype=lisp

" this needs to be at the end since it's (re)set when compatible is (re)set
autocmd BufNewFile,BufRead * setlocal formatoptions-=o " disable comment continuation for o/O (use enter)

hi SyntasticErrorSign term=bold cterm=bold ctermfg=1 ctermbg=0 guifg=White guibg=Red
hi SyntasticWarningSign ctermbg=0

let w:toggleFold = 0
let w:toggleSignColumn = "no"
function ToggleFold()
  set number!
  let l:curr = &foldcolumn
  let &foldcolumn = w:toggleFold
  let w:toggleFold = l:curr
  GitGutterToggle
  let l:tmp = &signcolumn
  let &signcolumn = w:toggleSignColumn
  let w:toggleSignColumn = l:tmp
endfunction

let mapleader = ","
" Enable folding with the spacebar
nnoremap <space> za

" insert a 'tab' regardless of expandtab
inoremap <s-tab> <c-v><tab>

inoremap <C-c> <Esc>

nnoremap <leader>g g<C-]>
vnoremap <leader>g g<C-]>
nnoremap <leader>t <C-t>
vnoremap <leader>t <C-t>

nnoremap <leader>d :bprevious<CR>
nnoremap <leader>f :bnext<CR>

set pastetoggle=<leader>p

" toggle highlighting the most-recently-found search text
nnoremap \th :set invhls hls?<CR>
nmap <leader>h \th

"
" Language Server Protocol
"
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_settings_enable_suggestions = 0

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  "nmap <buffer> gi <plug>(lsp-implementation)
  "nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  inoremap <buffer> <expr><c-f> lsp#scroll(+4)
  inoremap <buffer> <expr><c-d> lsp#scroll(-4)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
