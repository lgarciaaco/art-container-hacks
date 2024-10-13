" From  https://learnvim.irian.to/basics/buffers_windows_tabs
" List opened buffers
:ls :buffers :files

" If you need to find in files (find phrases in files), you can use grep. Vim has two ways of doing that:
" Internal grep (:vim)

:vim /pattern/ file

" For example, to look for all occurrences of "breakfast" string inside all ruby files (.rb) inside app/controllers/ directory:
:vim /breakfast/ app/controllers/**/*.rb

" After running that, you will be redirected to the first result. Vim's vim search command uses quickfix operation. To see all search results, run :copen. This opens a quickfix window. Here are some useful quickfix commands to get you productive immediately:
:copen        Open the quickfix window
:cclose       Close the quickfix window
:cnext        Go to the next error
:cprevious    Go to the previous error
:colder       Go to the older error list
:cnewer       Go to the newer error list

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins:
" bufexplorer.zip: Quickly and easily switch between buffers. This plugin can be opened with <leader+o>
" ctrlp.vim: Fuzzy file, buffer, mru and tag finder. It's mapped to <Ctrl+F>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Open ctrlp.vim plugin to quickly find a file or a buffer (<leader>j or <ctrl>f):
" Quickly find and open a file in the CWD
let g:ctrlp_map = '<C-f>'

" Quickly find and open a recently opened file
map <leader>f :MRU<CR>

" Quickly find and open a buffer
map <leader>b :CtrlPBuffer<cr>"
