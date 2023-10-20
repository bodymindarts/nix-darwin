colorscheme jellybeans

set hidden
set autoindent
set autoread                       " auto reload when file changes
set autowrite                      " Automatically :write before running commands
set backspace=indent,eol,start     " allow backspace over eol etc.
set colorcolumn=91                 " line width delimiter
set cursorline                     " highlight line at cursor set hlsearch set ignorecase set incsearch
set expandtab                      " use n times <space> instead of <tab>
set foldmethod=manual              " no automatic folding
set hlsearch                       " highlight all search results
set ignorecase                     " ignore case when searching
set incsearch                      " highlight while typing search
set laststatus=2                   " line for status of window
set list                           " show symbols for <eol> and <tab>
set listchars=tab:▸\ ,eol:¬        " set symbols for <eol> and <tab>
set nobackup                       " no backups, no swapfiles
set nofoldenable                   " no automatic folding
set noswapfile                     " no backups, no swapfiles
set nowritebackup                  " no backups, no swapfiles
set number                         " line number
set shiftwidth=2
set showtabline=2                  " always have tab line
set smartcase                      " search is case sensitive when word starts with uppercase
set softtabstop=2
set splitbelow                     " split opens new window below
set splitright                     " vsplit opens new window to the right
set statusline=%f\ %m%r%y%=%3l,%2c
set tabstop=2                      " spaces per tab
set tags+=.git/tags,./.tags
set undodir=~/.config/nvim/undo//
set undofile
set undolevels=1000
set undoreload=10000
set visualbell                     " no beeping
set wildmenu                       " show menu of complete option
let g:vimsyn_embed = 'l'

let mapleader=" "
let maplocalleader=","

augroup vimrc
  autocmd!
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g`\"" |
        \ endif
augroup end

nnoremap <leader>r :ALERename<cr>
nnoremap <leader>ev :tabe ~/.config/nix-darwin/programs/neovim/default.nix<cr>
nnoremap <leader>eh :tabe ~/.config/nix-darwin/home-manager.nix<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :tabe ~/.config/nix-darwin/programs/zsh/default.nix<cr>

nnoremap <leader>x :w<cr>:!chmod +x %<cr>:edit!<cr>
nnoremap <leader>m :!mkdir -p %:p:h<cr>
nnoremap <leader>w :w<cr>
inoremap UU <esc>u
inoremap jj <esc>
" Quicker window movement
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Quicker open alternate
nnoremap <leader><leader> <c-^>
" split window and reset to last
nnoremap vv <c-w>v<c-w>h<c-^>

function! GetBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endfunction

function! BufferIsOpen(bufname)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            return 1
        endif
    endfor
    return 0
endfunction

function! ToggleQuickfix()
    if BufferIsOpen("Quickfix List")
        cclose
    else
        call OpenQuickfix()
    endif
endfunction

function! OpenQuickfix()
    botright cwindow
    if &ft == "qf"
        cc
    endif
endfunction

nnoremap <leader>q :call ToggleQuickfix()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>N :call RenameFile()<cr>

augroup TypeScriptOverrides
    autocmd!
    autocmd BufRead,BufNewFile *.ts,*.tsx,*.js,*.json call s:DefineEslintFunction()
augroup END

function! s:DefineEslintFunction()
  function! ale#handlers#eslint#GetCwd(buffer) abort
      " Obtain the path to the ESLint configuration
      let l:config_path = ale#handlers#eslint#FindConfig(a:buffer)

      " Extract the directory from the config path
      let l:config_dir = fnamemodify(l:config_path, ':h')

      " Return the directory as the cwd
      return l:config_dir
  endfunction
endfunction
