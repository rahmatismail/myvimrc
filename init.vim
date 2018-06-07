if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Color scheme
Plug 'romainl/Apprentice'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" IDE
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'vim-airline/vim-airline'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/Improved-AnsiEsc'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'

" Autocompletion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'wokalski/autocomplete-flow'
" For func argument completion
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Plug 'dyng/ctrlsf.vim'

" Git
Plug 'tpope/vim-fugitive', {'statusline': '%{fugitive#statusline()}'}

" Syntax completion
Plug 'w0rp/ale'
" Plug 'https://github.com/Quramy/tsuquyomi.git'

" Go
Plug 'fatih/vim-go'

" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

call plug#end()

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
" color dracula
" syntax on
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:ale_lint_on_text_changed = 'never'
set completeopt=longest,menuone,noinsert,preview
" nvim cursor bug on command line and ctrlp
set guicursor=
set updatetime=100
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:neosnippet#enable_completed_snippet = 1
" prettier
let g:prettier#config#use_tabs = 'true'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" key remapping
autocmd VimEnter * nmap <F3> :NERDTreeToggle<CR>
autocmd VimEnter * imap <F3> <Esc>:NERDTreeToggle<CR>
autocmd VimEnter * nmap <F4> :NERDTreeFind<CR>
autocmd VimEnter * imap <F4> <Esc>:NERDTreeFind<CR>
autocmd VimEnter * nmap <F5> :GoRun<CR>
autocmd VimEnter * imap <F5> <Esc>:GoRun<CR>
autocmd VimEnter * nmap <F2> <Esc>:noh<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
autocmd VimEnter * map <silent> <C-u> :tabm -1<CR>
autocmd VimEnter * map <silent> <C-i> :tabm +1<CR>
nnoremap <C-\> :tabclose<CR>
map <C-n> :cn<CR>
map <C-m> :cp<CR>
inoremap <C-Space> <C-x><C-o><C-n>
autocmd BufEnter,VimLeavePre :source ~/.nvim_session
autocmd FileType term wincmd J

if empty(glob("~/.nvim_session"))
    :NERDTreeToggle
    autocmd VimEnter * wincmd w
    autocmd VimEnter * :NERDTreeFind
    autocmd VimEnter * wincmd w
else
    autocmd VimEnter :mksession! ~./nvim_session
endif

" autocmd VimEnter * :IndentLinesEnable
" set list lcs=tab:\¦\  

" trigger completion menu on dot char
function! OpenCompletion()
	" if !pumvisible() && (v:char == '.' || (v:char >= 'a' && v:char <= 'z') && "<cword>" != "func")
	if !pumvisible() && v:char == '.'
		" open omni completion and highlight first option
		call feedkeys("\<C-x>\<C-o>\<C-n>", "n")
	endif
endfunction

" Change enter behavior to be <C-y>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
" endif
