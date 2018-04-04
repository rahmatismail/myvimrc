" :augroup numbertoggle
" :  autocmd!
" :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
" :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" :augroup END

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Color scheme
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'

" IDE Tools
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'https://github.com/kien/ctrlp.vim.git'
" Plug 'dyng/ctrlsf.vim'

" Git
Plug 'tpope/vim-fugitive', {'statusline': '%{fugitive#statusline()}'}

" Syntax completion
Plug 'w0rp/ale'
" Plug 'https://github.com/Quramy/tsuquyomi.git'

" Go
Plug 'fatih/vim-go'

call plug#end()

" key remapping
autocmd VimEnter * nmap <F3> :NERDTreeToggle<CR>
autocmd VimEnter * imap <F3> <Esc>:NERDTreeToggle<CR>
autocmd VimEnter * nmap <F4> :NERDTreeFind<CR>
autocmd VimEnter * imap <F4> <Esc>:NERDTreeFind<CR>
autocmd VimEnter * nmap <F2> <Esc>:noh<CR>
let g:ale_lint_on_text_changed = 'never'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
autocmd VimEnter * map <silent> <C-u> :tabm -1<CR>
autocmd VimEnter * map <silent> <C-i> :tabm +1<CR>
nnoremap <C-Delete> :tabclose<CR>
map <C-n> :cn<CR>
map <C-m> :cp<CR>
inoremap <C-Space> <C-x><C-o><C-n>

" set IDE pref
set number
set tabstop=4 shiftwidth=4
set expandtab
set ignorecase
set smartcase
set diffopt=vertical,filler
set nowrap
set title
colorscheme gruvbox
set background=dark

" NERDTree stuff
:NERDTreeToggle
autocmd VimEnter * wincmd w
autocmd VimEnter * :NERDTreeFind
autocmd VimEnter * wincmd w
" auto open nerd tree on TabEnter. Still buggy
" function! IsNerdTreeEnabled()
" 	return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
" endfunction
" autocmd TabEnter * if !IsNerdTreeEnabled() | :NERDTreeToggle | endif

" omnicompletion
" always show menu
set completeopt=longest,menuone,noinsert,preview
" trigger with . and alphabet keypress
" TODO make vim popup works on alphabet keypress. And stop struggling if no
" word match
function! OpenCompletion()
	" if !pumvisible() && (v:char == '.' || (v:char >= 'a' && v:char <= 'z') && "<cword>" != "func")
	if !pumvisible() && v:char == '.'
		" open omni completion and highlight first option
		call feedkeys("\<C-x>\<C-o>\<C-n>", "n")
	endif
endfunction
autocmd InsertCharPre *.go call OpenCompletion()
" Change enter behavior to be <C-y>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" nvim cursor bug on command line and ctrlp
set guicursor=
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
" inoremap <C-@> <C-Space>
