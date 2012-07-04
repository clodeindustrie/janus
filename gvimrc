set guioptions-=T  "Start without the toolbar
set guioptions-=m  "remove menu bar
set guioptions-=r  "remove right-hand scroll bar

if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert
  set guifont=Monaco:h12

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :CommandT<CR>
  imap <D-t> <Esc>:CommandT<CR>

  map <D-b> :CommandTBuffer<CR>
  imap <D-b> <Esc>:CommandTBuffer<CR>

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  map <D-?> <plug>NERDCommenterToggle<CR>

  " Command-][ to increase/decrease indentation
  vmap <D-]> >gv
  vmap <D-[> <gv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt

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

  vmap <A-/><plug>NERDCommenterComment
  imap <A-/><plug>NERDCommenterComment
  map <A-/><plug>NERDCommenterComment
elseif has("gui_gtk2")
  " should bundle the font file for linux with
  " the config files
  set gfn=Monaco\ 10

  color solarized
endif

" Open new tab
map T :tabnew

"
" Don't beep
set visualbell

" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif
