" ca veut dire que quand tu peu utiliser backspace sur tout type de character
set backspace=indent,eol,start

" Quand tu utilise ta souris pour selectioner du text, il se met en visual mode
set mouse=a
set selectmode=mouse

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

" enleve le wrapping
set nowrap

" les 'tab' sont en fait des espaces, 4 en l'occurence
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" affiche les trailing spaces avec un point
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.png,*.jpg,*.gif,*.log

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

" <Space> is the leader character le leader est juste une facon de mapper plein de shortcuts base sur une seule touche
let mapleader = " "
let g:mapleader = " "

" Pour le plugin Command T
map tt :CommandT<CR>
let g:CommandTMaxFiles=30000

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
map <Leader>r :TagbarToggle <CR>

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

" Auto deploy on save
function! Deploy(toto)
    :w
    if match(a:toto, "\/home\/sites\/") >= 0
        exe "!poo pooh " . a:toto
        echo "Done"
    endif
endfunction
command W :call Deploy(expand('%:p'))

" au BufWritePost *.php,*.js,*.phtml,*.html,*.ini call Deploy(expand('<afile>:p'))

" Default Color scheme
colorscheme desert

" Tags
" let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" bubble ca veut dire bouger des lines entiere dans le fichier
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

" Use modeline overrides
set modeline
set modelines=10

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" Show (partial) command in the status line
set showcmd

" Command-][ to increase/decrease indentation
vmap <A-]> >gv
vmap <A-[> <gv

" Command-Option-ArrowKey to switch viewports
map <A-Up> <C-w>k
imap <A-Up> <Esc> <C-w>k
map <A-Down> <C-w>j
imap <A-Down> <Esc> <C-w>j
map <A-Right> <C-w>l
imap <A-Right> <Esc> <C-w>l
map <A-Left> <C-w>h
imap <A-Left> <C-w>h

" Some split windows commodities
map <A-o> :ZoomWin<CR>
imap <A-o> :ZoomWin<CR>
map <A-q> <C-w>q
imap <A-q> <C-w>q
map <A-n> <C-w>n
imap <A-n> <C-w>n
map <A-v> <C-w>v
map <A-v> <C-w>v
imap <A-s> <C-w>s
imap <A-s> <C-w>s

set conceallevel=2
" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
