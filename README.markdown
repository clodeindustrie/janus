## Pre-requisites
Linux users can install `gvim` for an experience identical to MacVim.
On Debian/Ubuntu, simply `apt-get install vim-gnome`. For remote
servers, install console vim with `apt-get install vim-nox`.

On a fresh Ubuntu install you also have to install the packages `rake` and `ruby-dev`
before running the install script and `exuberant-ctags` for ctags
support.

## Installation
1. `git clone git://github.com/clodeindustrie/janus.git ~/.vim`
2. `cd ~/.vim`
3. `rake`

## Customization

Create `~/.vimrc.local` and `~/.gvimrc.local` for any local
customizations.

For example, to override the default color schemes:

    echo color desert  > ~/.vimrc.local
    echo color molokai > ~/.gvimrc.local

If you want to add additional Vim plugins you can do so by adding a
`~/.janus.rake` like so:

    vim_plugin_task "zencoding", "git://github.com/mattn/zencoding-vim.git"
    vim_plugin_task "minibufexpl", "git://github.com/fholgado/minibufexpl.vim.git"

# Intro to VIM

Here's some tips if you've never used VIM before:

## Tutorials

* Type `vimtutor` into a shell to go through a brief interactive
  tutorial inside VIM.
* Read the slides at [VIM: Walking Without Crutches](http://walking-without-crutches.heroku.com/#1).

## Modes

* VIM has two modes:
  * insert mode- stuff you type is added to the buffer
  * normal mode- keys you hit are interpretted as commands
* To enter insert mode, hit `i`
* To exit insert mode, hit `<ESC>`

## Useful commands

* Use `:q` to exit vim
* Certain commands are prefixed with a `<Leader>` key, which maps to `\`
  by default. Use `let mapleader = ","` to change this.
* Keyboard [cheat sheet](http://walking-without-crutches.heroku.com/image/images/vi-vim-cheat-sheet.png).

# Features

This vim distribution includes a number of packages built by others.

## Base Customizations

Janus ships with a number of basic customizations for vim:

* Line numbers
* Ruler (line and column numbers)
* No wrap (turn off per-buffer via set :wrap)
* Soft 2-space tabs, and default hard tabs to 2 spaces
* Show tailing whitespace as `.`
* Make searching highlighted, incremental, and case insensitive unless a
  capital letter is used
* Always show a status line
* Allow backspacing over everything (identations, eol, and start
  characters) in insert mode
* `<Leader>e` expands to `:e {directory of current file}/` (open in the
  current buffer)
* `<Leader>tr` expands to `:te {directory of current file}/` (open in a
  new MacVIM tab)
* `<C-P>` inserts the directory of the current file into a command
* Automatic insertion of closing quotes, parenthesis, and braces

## "Project Drawer" aka NERDTree

NERDTree is a file explorer plugin that provides "project drawer"
functionality to your vim projects.  You can learn more about it with
:help NERDTree.

**Customizations**: Janus adds a number of customizations to the core
NERDTree:

* Use `<Leader>n` to toggle NERDTree
* Ignore `*.rbc` and `*~` files
* Automatically activate NERDTree when MacVIM opens and make the
  original buffer the active one
* Provide alternative :e, :cd, :rm and :touch abbreviations which also
  refresh NERDTree when done (when NERDTree is open)
* When opening vim with vim /path, open the left NERDTree to that
  directory, set the vim pwd, and clear the right buffer
* Disallow `:e`ing files into the NERDTree buffer
* In general, assume that there is a single NERDTree buffer on the left
  and one or more editing buffers on the right

## Align

Align lets you align statements on their equal signs, make comment
boxes, align comments, align declarations, etc.

* `:5,10Align =>` to align lines 5-10 on `=>`'s

## Command-T

Command-T provides a mechanism for searching for a file inside the
current working directory. It behaves similarly to command-t in
Textmate.

**Customizations**: Janus rebinds command-t (`<D-t>`) to bring up this
plugin. It defaults to `<Leader>t`.

## indent\_object

Indent object creates a "text object" that is relative to the current
ident. Text objects work inside of visual mode, and with `c` (change),
`d` (delete) and `y` (yank). For instance, try going into a method in
normal mode, and type `v ii`. Then repeat `ii`.

**Note**: indent\_object seems a bit busted. It would also be nice if
there was a text object for Ruby `class` and `def` blocks.

## surround

Surround allows you to modify "surroundings" around the current text.
For instance, if the cursor was inside `"foo bar"`, you could type
`cs"'` to convert the text to `'foo bar'`.

There's a lot more; check it out at `:help surround`

## NERDCommenter

NERDCommenter allows you to wrangle your code comments, regardless of
filetype. View `help :NERDCommenter` for all the details.

**Customizations**: Janus binds command-/ (`<D-/>`) to toggle comments.

## SuperTab

In insert mode, start typing something and hit `<TAB>` to tab-complete
based on the current context.

## ctags

Janus includes the TagList plugin, which binds `:Tlist` to an overview
panel that lists all ctags for easy navigation.

**Customizations**: Janus binds `<Leader>rt` to the ctags command to
update tags.

**Note**: For full language support, run `brew install ctags` to install
exuberant-ctags.

**Tip**: Check out `:help ctags` for information about VIM's built-in
ctag support. Tag navigation creates a stack which can traversed via
`Ctrl-]` (to find the source of a token) and `Ctrl-T` (to jump back up
one level).

## Git Support (Fugitive)

Fugitive adds pervasive git support to git directories in vim. For more
information, use `:help fugitive`

Use `:Gstatus` to view `git status` and type `-` on any file to stage or
unstage it. Type `p` on a file to enter `git add -p` and stage specific
hunks in the file.

Use `:Gdiff` on an open file to see what changes have been made to that
file

## Additional Syntaxes

Janus ships with a few additional syntaxes:

* An improved JavaScript syntax (bound to \*.js)
* Map Gemfile, Rakefile, Vagrantfile and Thorfile to Ruby
* Git commits (set your `EDITOR` to `mvim -f`)

## Color schemes

there is only solarized

