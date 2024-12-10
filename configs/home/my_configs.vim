let g:NERDTreeWinPos = "left"
let g:indent_guides_enable_on_vim_startup = 1

" Close current buffer
map <leader>c :Bclose<cr>

" Automatically cd when switching bookmarks
let NERDTreeChDirMode=2

" NERDTree related configuration
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

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
