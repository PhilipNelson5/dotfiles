let mapleader="\<SPACE>"
nnoremap <leader>w :w<CR>

set ignorecase
set smartcase

" https://github.com/LunarVim/LunarVim/blob/d002b0419a8621c5575c14119d0b8d9c4a7a44a0/vscode/settings.vim
if exists('g:vscode')

    " Better Navigation
    nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
    xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>

    nmap <Tab> :Tabnext<CR>
    nmap <S-Tab> :Tabprev<CR>
endif