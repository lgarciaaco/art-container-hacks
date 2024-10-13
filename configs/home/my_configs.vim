let g:NERDTreeWinPos = "left"

" Automatically cd when switching bookmarks
let NERDTreeChDirMode=2

" Change colorscheme to something light since in fedora dark is like a blackhole
colorscheme mayansmoke

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Always open the bookmark table
let NERDTreeShowBookmarks=1

" Install some usable search
set rtp+=/usr/local/bin/fzf
