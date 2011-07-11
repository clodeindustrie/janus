set guioptions-=T  "Start without the toolbar
set guioptions-=m  "remove menu bar
set guioptions-=r  "remove right-hand scroll bar

" should bundle the font file for linux with
" the config files
set gfn=Monaco\ 10

" Should add the theme install to the
" rakefile
set background=dark
colorscheme solarized

" Common shortcuts

" Open new tab
map T :tabnew 


" should add a if guimac and change the 
" shortcut to use the apple key
if has("gui")

  " Command-][ to increase/decrease indentation
  map <A-]> >gv
  map <A-[> <gv

  " Map Command-# to switch tabs
  map  <A-0> 0gt
  imap <A-0> <Esc>0gt
  map  <A-1> 1gt
  imap <A-1> <Esc>1gt
  map  <A-2> 2gt
  imap <A-2> <Esc>2gt
  map  <A-3> 3gt
  imap <A-3> <Esc>3gt
  map  <A-4> 4gt
  imap <A-4> <Esc>4gt
  map  <A-5> 5gt
  imap <A-5> <Esc>5gt
  map  <A-6> 6gt
  imap <A-6> <Esc>6gt
  map  <A-7> 7gt
  imap <A-7> <Esc>7gt
  map  <A-8> 8gt
  imap <A-8> <Esc>8gt
  map  <A-9> 9gt
  imap <A-9> <Esc>9gt

  " Command-Option-ArrowKey to switch viewports
  map <A-Up> <C-w>k
  imap <A-Up> <Esc> <C-w>k
  map <A-Down> <C-w>j
  imap <A-Down> <Esc> <C-w>j
  map <A-Right> <C-w>l
  imap <A-Right> <Esc> <C-w>l
  map <A-Left> <C-w>h
  imap <A-Left> <C-w>h
endif


autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()


" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction


" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . fnameescape(a:dir)
  let stay = exists("a:1") ? a:1 : 1

  NERDTree

  if !stay
    wincmd p
  endif
endfunction

call s:DefineCommand("cd", "ChangeDirectory")

" Include user's local vim config
if filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif
