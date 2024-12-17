let g:NERDTreeWinPos = "left"
let g:indent_guides_enable_on_vim_startup = 1
map <leader>nn :NERDTreeFromBookmark<Space>

" Automatically cd when switching bookmarks
let NERDTreeChDirMode=2

" NERDTree related configuration
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
au BufEnter * if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && winnr('$') > 1 | b# | exe "normal! \<c-w>\<c-w>" | :blast | endif

" Always open the bookmark table
let NERDTreeShowBookmarks=1

" Install some usable search aka fzf / rg
" https://github.com/junegunn/fzf.vim?tab=readme-ov-file
set rtp+=/usr/local/bin/fzf

" Maps for fzf and rg
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>o :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" maps for fugitive
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Git branch -vv<CR>
nnoremap <Leader>gh :Silent Glog<CR>
nnoremap <Leader>gH :Silent Glog<CR>:set nofoldenable<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git pull<CR>
nnoremap <Leader>g- :Silent Git stash<CR>:e<CR>
nnoremap <Leader>g+ :Silent Git stash pop<CR>:e<CR>

" Close current buffer
map <leader>c :Bclose<cr>

" Trim white spaces automatically from all files when saving
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    keeppatterns %s/\n\{3,}/\r\r/e
    call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

autocmd BufWritePre * call TrimWhitespace()

" Set relative number lines for better mobility
set relativenumber number

" Map escape to quickly hitting `ii`, since entering insert mode is done
" with `i` it is more INTUITIVE this way
inoremap ii <Esc>

" Change color schema
try
    colorscheme gruvbox
catch
endtry

" Configurations for wiki
let g:vimwiki_list = [{'path': '~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Wiki/', 'syntax': 'markdown', 'links_space_char': '_', 'ext': 'md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {}
hi VimwikiLink term=underline gui=underline

" Let fzf complete line with C-f in insert mode
imap <C-f> <plug>(fzf-complete-line)
