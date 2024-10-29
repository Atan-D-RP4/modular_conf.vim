"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / | | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
set nocompatible

" XDG Compatibility
" -----------------------
" Assign the defaults when the environment doesn't provide them.
if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = $HOME.'/.cache'
endif
if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME.'/.config'
endif
if empty($XDG_DATA_HOME)
  let $XDG_DATA_HOME = $HOME.'/.local/share'
endif

" Make sure any configuration directories/paths exist.
if !isdirectory($XDG_CACHE_HOME."/vim/swap")
  call mkdir($XDG_CACHE_HOME."/vim/swap", "p")
endif
if !isdirectory($XDG_CACHE_HOME."/vim/backup")
  call mkdir($XDG_CACHE_HOME."/vim/backup", "p")
endif
if !isdirectory($XDG_CACHE_HOME."/vim/undo")
  call mkdir($XDG_CACHE_HOME."/vim/undo", "p")
endif

" Set directory paths
let &undodir=$XDG_CACHE_HOME.'/vim/undo'
let &directory=$XDG_CACHE_HOME.'/vim/swap' 
let &backupdir=$XDG_CACHE_HOME.'/vim/backup'
let &viewdir=$XDG_CACHE_HOME.'/vim/view'
let &runtimepath=expand('$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after')
let g:netrw_home=$XDG_CACHE_HOME.'/vim'

" Set leader keys
let mapleader = " "
let maplocalleader = " "

" Set important directory variables
let vim_home = $XDG_CONFIG_HOME . '/vim'
let data_dir = $XDG_DATA_HOME . '/vim'

source $XDG_CONFIG_HOME/vim/statusline.vim		      " Load custom statusline theme

let mapleader = " "
let maplocalleader = " "
" Set important directory variables
let vim_home = $XDG_CONFIG_HOME . '/vim'
let data_dir = $XDG_DATA_HOME . '/vim'

" Source statusline if it exists
if filereadable(vim_home . '/statusline.vim')
  execute 'source' vim_home . '/statusline.vim'
endif

" Load mods (keymaps, opts, utils, autocmds, etc)
for mod_file in split(glob(vim_home . '/mods/*.vim', 1), '\n')
  if filereadable(mod_file)
    execute 'source' mod_file
  endif
endfor

" Bootstrap vim-plug in correct XDG_DATA_HOME location
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Initialize vim-plug and load plugins
if filereadable($XDG_CONFIG_HOME.'/vim/autoload/plug.vim')
call plug#begin(data_dir . '/plugins')
    " Load all plugin configurations
    for plug_file in split(glob(vim_home . '/plugs/*.vim', 1), '\n')
      if filereadable(plug_file)
	execute 'source' plug_file
      endif
    endfor
  call plug#end()
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC " Make an actual plugins.vim instead
endif
