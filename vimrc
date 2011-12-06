set nocompatible " vi stuff
set backspace=2
set backspace=indent,eol,start

" Have file syntax on
filetype on
filetype plugin on
filetype indent on
syntax on

"show line number
set number
set ruler

" Set encoding
set encoding=utf-8

" Whitespace stuff & tabs
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2
set history=50     " keep 50 lines of command line history
set showcmd        " display incomplete commands

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" <Space> is the leader character
let mapleader = " "
let g:mapleader = " "

map tt :CommandT<CR>
map <Leader>n :NERDTreeToggle<CR>
map <Leader>q :NERDTreeClose <CR>

"external copy paste
nmap <C-y> "+y
nmap <C-p> "+p
vmap <C-y> "+y
vmap <C-p> "+p

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
" map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Open the panel with ctags
map <Leader>r :TlistToggle <CR>

" Open buffer list
:nnoremap <F5> :buffers<CR>:buffer<Space>

" No Help, please
nmap <F1> <Esc>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

au BufRead,BufNewFile *.txt call s:setupWrapping()

" Should add test for phpcs existence
function! RunPhpcs()
    let l:quote_token="'"
    let l:filename=@%
    let l:phpcs_output=system('phpcs --report=csv --standard=Dwin '.l:filename)
    let l:phpcs_output=substitute(l:phpcs_output, '\\"', l:quote_token, 'g')
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    cwindow
endfunction

" set errorformat=%E\"%f\"\\,%l\\,%c\\,error\\,\"%m\"\\,%*[a-zA-Z.],%W\"%f\"\\,%l\\,%c\\,warning\\,\"%m\"\\,%*[a-zA-Z.],%-GFile\\,Line\\,Column\\,Severity\\,Message\\,Source
set errorformat=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"\\,%*[a-zA-Z0-9_.-]\\,%*[0-9] 
" set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"\\,%*[a-zA-Z0-9_.-]
command! Phpcs execute RunPhpcs()

" should add test for existence of poo
function! DoDtrac(ticket)
    exe "!poo dt " . a:ticket
endfunction
command -nargs=1  Dtrac  :call DoDtrac(<q-args>)

function! ChangeSet(number)
    exe "!poo cs " . a:number
endfunction
command -nargs=1  Changes  :call ChangeSet(<q-args>)

function! DoStrac(ticket)
    exe "!poo str " . a:ticket
endfunction
command -nargs=1  Strac  :call DoStrac(<q-args>)

function! DoBrowse(filo)
    exe "!poo b " . a:filo
endfunction
command Browse :call DoBrowse(expand('%:p'))

command Revert :!svn revert %

" Auto deploy on save
function! Deploy(toto)
    if match(a:toto, "\/home\/sites\/") >= 0
        exe "!poo pooh " . a:toto
        echo "Done"
    endif
endfunction

au BufWritePost *.php,*.js,*.phtml,*.html,*.ini call Deploy(expand('<afile>:p'))
 
" Default Color scheme
colorscheme desert

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
map <leader>px :PrettyXML

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Command-T configuration
let g:CommandTMaxHeight=20

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap < <><LEFT>
"
" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
" colorscheme ir_black
set background=dark
colorscheme solarized
"
" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
"let macvim_hig_shift_movement = 1

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
