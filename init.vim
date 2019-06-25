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
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-multiple-cursors'
" Plug 'jiangmiao/auto-pairs'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/Improved-AnsiEsc'
Plug 'Yggdroot/indentLine'
Plug 'ramele/agrep'
" Plug 'majutsushi/tagbar'

" Autocompletion
Plug 'Shougo/deoplete.nvim', {'tag': '4.0'}
Plug 'zchee/deoplete-go'
" ", {'do': 'make'}
" Plug 'wokalski/autocomplete-flow'
" For func argument completion
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'dyng/ctrlsf.vim'

" Git
Plug 'tpope/vim-fugitive', {'statusline': '%{fugitive#statusline()}'}
Plug 'airblade/vim-gitgutter'
" Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

" Syntax check
Plug 'w0rp/ale'
" Plug 'https://github.com/Quramy/tsuquyomi.git'

" Go
Plug 'fatih/vim-go', {'tag':'v1.18'}
Plug 'buoto/gotests-vim'

" Typescript Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

" HTML
Plug 'mattn/emmet-vim'

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
set mouse=a
colorscheme gruvbox
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
" color dracula
" syntax on
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
let g:ale_lint_on_text_changed = 'never'
set completeopt=noinsert,preview
" nvim cursor bug on command line and ctrlp
set guicursor=
" let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
"       \ --ignore .git
"       \ --ignore .svn
"       \ --ignore .hg
"       \ --ignore .DS_Store
"       \ -g ""'

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" set updatetime=500
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" let g:neosnippet#enable_completed_snippet = 1
" prettier
let g:prettier#config#use_tabs = 'true'
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
" delimitMate
let delimitMate_expand_cr = 1
au FileType maail let delimitMate_expand_cr = 1
" airline
let g:airline#extensions#tabline#formatter = 'unique_tail'
" emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" gitgutter
let g:gitgutter_max_signs = 3000

" key remapping
autocmd VimEnter * nmap <F3> :NERDTreeToggle<CR>
autocmd VimEnter * imap <F3> <Esc>:NERDTreeToggle<CR>
autocmd VimEnter * nmap <F4> :NERDTreeFind<CR>
autocmd VimEnter * imap <F4> <Esc>:NERDTreeFind<CR>
autocmd VimEnter * nmap <F5> :GoRun<CR>
autocmd VimEnter * imap <F5> <Esc>:GoRun<CR>
autocmd VimEnter * nmap <F2> <Esc>:noh<CR>
autocmd VimEnter * nnoremap <F6> :TagbarToggle<CR>
autocmd VimEnter * inoremap <F6> <Esc>:TagbarToggle<CR>
autocmd VimEnter * nnoremap <F9> :call ToggleBackground()<CR>
autocmd VimEnter * nnoremap <F9> <Esc>:call ToggleBackground()<CR>
autocmd VimEnter * nnoremap <C-s> :w<CR>
autocmd VimEnter * inoremap <C-s> <Esc>:w<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
autocmd VimEnter * map <silent> <C-u> :tabm -1<CR>
autocmd VimEnter * map <silent> <C-i> :tabm +1<CR>
nnoremap <C-\> :tabclose<CR>
map <C-n> :cn<CR>
map <C-m> :cp<CR>
inoremap <C-Space> <C-x><C-o><C-n>
vnoremap <C-c> :w !pbcopy<CR><CR>
" Replace word inside selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
autocmd BufEnter,VimLeavePre :source ~/.nvim_session
autocmd FileType term wincmd J
" autocmd BufWritePost *.go :GoImports

if empty(glob("~/.nvim_session"))
    :NERDTreeToggle
    autocmd VimEnter * wincmd w
    autocmd VimEnter * :NERDTreeFind
    autocmd VimEnter * wincmd w
    " autocmd VimEnter * :TagbarOpen
    " autocmd TabEnter * :TagbarOpen
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

" toggle background
function! ToggleBackground()
    if &background=="dark"
        set background=light
    else
        set background=dark
    endif
endfunction

" Change enter behavior to be <C-y>
" inoremap <expr> <CR> pumvisible() ? \\\\"\<C-y>" : \\\\"\<C-g>u\<CR>"

" if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
" endif
"
