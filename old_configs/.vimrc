" BASIC SETUP: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible               " Upgrading from vi to vim
filetype off                   " Helps force plug-ins to load correctly when it is turned back on below
syntax enable                  " syntax highlighting
filetype plugin indent on      " filetype detection and language-dependent indenting
set encoding=utf-8             " Default encoding is latin1
set hidden                     " Allow hidden buffers, don't limit to 1 file per window/split
set ttyfast                    " Speed up scrolling
set noswapfile                 " no swap files
set nobackup                   " Don't keep backup file after successfully writing
set nowritebackup              " No backup file is made
set nowrap                     " No wrapping
let mapleader = ","            " Set map key
" }}}
" SPACES AND TABBING: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4                  " with that a <TAB> character displays as
set expandtab                  " tabs to spaces
set shiftwidth=4               " number of spaces to use for each set of (autoindent)
set softtabstop=4              " backspace after presing <TAB> will remove up to this many spaces
set autoindent                 " copy indent from current line when starting a new line
set smartindent                " add indent after '{'
set backspace=indent,eol,start " natural backspace behavior

" }}}
" BUFFERS AND WINDOW_TABS: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" }}}
" FILE SPECIFIC: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup configgroup
    autocmd!
    au BufNewFile,BufRead *.jinja set syntax=htmljinja
    au BufNewFile,BufRead *.mako set ft=mako
    au FileType python inoremap <buffer> $r return
    au FileType python inoremap <buffer> $i import
    au FileType python inoremap <buffer> $p print
    au FileType python inoremap <buffer> $f # --- <esc>a
    au FileType python map <buffer> F :set foldmethod=indent<cr>
    au FileType python map <buffer> <leader>1 /class
    au FileType python map <buffer> <leader>2 /def
    au FileType python map <buffer> <leader>C ?class
    au FileType python map <buffer> <leader>D ?def
    au Filetype rmarkdown setlocal ts=2 sw=2 expandtab
    au FileType r map <buffer> F :set foldmethod=indent<cr>
    au Filetype r         setlocal ts=2 sw=2 expandtab
    au Filetype sql       setlocal ts=2 sw=2 expandtab
    au BufEnter Makefile setlocal noexpandtab
    au BufEnter *.sh setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END
" }}}
" FINDING FILES: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu
"     FIND FILES: {{{
"     - Hit tab to :find by partial match
"     - Use * to make it fuzzy
"     - :b lets you autocomplete any open buffer
"     }}}

" Ignore compiled files
set wildignore=*.o,*.obj,*~,*.pyc "stuff to ignore when tab completing
set wildignore+=.env
set wildignore+=.env[0-9]+
set wildignore+=.git
set wildignore+=.coverage
set wildignore+=*DS_Store*
set wildignore+=.sass-cache/
set wildignore+=__pycache__/
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.tox/**
set wildignore+=.idea/**
set wildignore+=*.egg,*.egg-info
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app
set wildignore+=renv/**

let g:netrw_list_hide='\.o,\.obj,*~,\.pyc,' "stuff to ignore when tab completing
let g:netrw_list_hide.='\.env,'
let g:netrw_list_hide.='\.env[0-9].,'
let g:netrw_list_hide.='\.git,'
let g:netrw_list_hide.='\.coverage$,'
let g:netrw_list_hide.='\.DS_Store,'
let g:netrw_list_hide.='__pycache__,'
let g:netrw_list_hide.='\.sass-cache/,'
let g:netrw_list_hide.='\.ropeproject/,'
let g:netrw_list_hide.='vendor/rails/,'
let g:netrw_list_hide.='vendor/cache/,'
let g:netrw_list_hide.='\.gem,'
let g:netrw_list_hide.='\.ropeproject/,'
let g:netrw_list_hide.='log/,'
let g:netrw_list_hide.='tmp/,'
let g:netrw_list_hide.='\.tox/,'
let g:netrw_list_hide.='\.idea/,'
let g:netrw_list_hide.='\.egg,\.egg-info,'
let g:netrw_list_hide.='\.png,\.jpg,\.gif,'
let g:netrw_list_hide.='\.so,\.swp,\.zip,/\.Trash/,\.pdf,\.dmg,/Library/,/\.rbenv/,'
let g:netrw_list_hide.='*/\.nx/**,*\.app'

set wildignore=*.o,*~,*.pyc
set wildignore+=*.egg,*.egg-info
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/tags
endif
" }}}
" SEARCH AND GREP: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch  " highlight matching [{()}]
set incsearch  " search as characters are entered
set hlsearch   " highlight searches
set ignorecase " including matching uppercase words with lowercase search
set smartcase  " include only uppercase words with uppercase search

" GREP: The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
"
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" }}}
" UI: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Wrap long lines
set wrap
set textwidth=79
set colorcolumn=80
set laststatus=2 " Status bar
set lazyredraw   " Only redraw when necessary
highlight Comment cterm=italic
"
" More natural splitting
set splitbelow
set splitright

" Show relative numbers
set number relativenumber

" Force true colour
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Presentation Mode
nmap <F5> :set relativenumber! number! showmode! showcmd! hidden! ruler! cc=0<CR>


" }}}
" FOLDING: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldlevelstart=10 " open fold with depth of 10
set foldnestmax=10    " don't fold more than 10 levels
set foldmethod=indent
" }}}
" SNIPPETS: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ,r :-1read $HOME/.vim/.skeleton.r<CR>
nnoremap ,stan :-1read $HOME/.vim/.skeleton.stan<CR>
" }}}
" PLUGINS: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'jpalardy/vim-slime'
Plug 'preservim/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'chr4/nginx.vim'
Plug 'eigenfoo/stan-vim'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'elzr/vim-json'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'hashivim/vim-terraform'
Plug 'stephpy/vim-yaml'
Plug 'ycm-core/YouCompleteMe'
call plug#end()
    " PLUGIN CONFIG: {{{
        " BASE16_VIM: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        if filereadable(expand("~/.vimrc_background"))
          let base16colorspace=256
          source ~/.vimrc_background
        endif
        " }}}
        " NERDTREE: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        let g:NERDTreeWinPos = "right"
        let g:NERDTreeWinSize= 35
        let NERDTreeShowHidden=0
        let NERDTreeIgnore=['\~$', '\.pyc', '\.swp$', '\.git', '\.hg', '\.svn',
             \ '\.ropeproject', '\.o', '\.bzr', '\.ipynb_checkpoints', '__pycache__',
             \ '\.egg$', '\.egg-info$', '\.tox$', '\.idea$', '\.sass-cache',
             \ '\.env$', '\.env[0-9]$', '\.coverage$']
        map <leader>nn :NERDTreeToggle<cr>
        " close vim if NERDTree is the only window left
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        " }}}
        " ALE: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        map <leader>ale :ALEToggle<cr>
        let g:ale_linters = {
          \   'python': ['flake8', 'pylint'],
          \}
        let g:ale_fixers = {
          \   '*': ['remove_trailing_lines', 'trim_whitespace'],
          \   'r': ['styler'],
          \   'json': ['fixjson'],
          \   'python': ['black'],
          \   'sql': ['pgformatter'],
          \}
        let g:ale_fix_on_save = 0
        let g:ale_python_pylint_use_global = 1
        let g:ale_sql_pgformatter_options = '--comma-start --redshift --keyword-case 2 --type-case 2 --function-case 2'
        " }}}
        " VIM-SLIM: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        if (!empty($TMUX))
          let g:slime_python_ipython = 1
          let g:slime_target = "tmux"
          let g:slime_paste_file = "$HOME/.slime_paste"
          let g:slime_default_config = {
            \ "socket_name": split($TMUX, ",")[0], "target_pane": ":.2"}
          let g:slime_dont_ask_default = 1
        endif
        set updatetime=100
        set clipboard=unnamed
        " }}}
        " LIGHTLINE: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        let g:lightline = {
          \ 'colorscheme': 'powerline',
          \ 'active': {
          \   'left': [[ 'mode', 'paste' ],
          \            [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
          \ },
          \ 'component_function': {'gitbranch': 'FugitiveHead'},
          \ }
        " FZF: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        nnoremap <C-p> :GFiles<Cr>
        " }}}
        " FUGITIVE: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        nmap <leader>gj :diffget //3<CR>
        nmap <leader>gf :diffget //2<CR>
        nmap <leader>gs :G<CR>
        " }}}
        " VIMTERRAFORM: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        let g:terraform_align=1
        let g:terraform_fold_sections=1
        let g:terraform_fmt_on_save=0
        " }}}
        " YOUCOMPLETEME: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        let g:ycm_auto_hover = ''
        " }}}
        " TAGBAR: {{{
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        nmap <leader>tb :TagbarToggle<CR>
        let g:tagbar_type_r = {
          \ 'ctagstype' : 'r',
          \ 'kinds'     : [
            \ 'f:Functions',
            \ 'g:GlobalVariables',
            \ 'v:FunctionVariables',
          \ ]
        \ }
        let g:tagbar_type_rmd = {
          \   'ctagstype':'rmd'
          \ , 'kinds':['h:header', 'c:chunk', 'f:function', 'v:variable']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header', 'c':'chunk'}
          \ , 'sort':0
          \ , 'ctagsbin':'/path/to/rmdtags.py'
          \ , 'ctagsargs': ''
        \ }
        let g:tagbar_type_ansible = {
          \ 'ctagstype' : 'ansible',
          \ 'kinds' : [
            \ 't:tasks'
          \ ],
          \ 'sort' : 0
        \ }
        let g:tagbar_type_json = {
          \ 'ctagstype' : 'json',
          \ 'kinds' : [
            \ 'o:objects',
            \ 'a:arrays',
            \ 'n:numbers',
            \ 's:strings',
            \ 'b:booleans',
            \ 'z:nulls'
          \ ],
          \ 'sro' : '.',
          \ 'scope2kind': {
            \ 'object': 'o',
            \ 'array': 'a',
            \ 'number': 'n',
            \ 'string': 's',
            \ 'boolean': 'b',
            \ 'null': 'z'
          \ },
          \ 'kind2scope': {
            \ 'o': 'object',
            \ 'a': 'array',
            \ 'n': 'number',
            \ 's': 'string',
            \ 'b': 'boolean',
            \ 'z': 'null'
          \ },
          \ 'sort' : 0
        \ }
        let g:tagbar_type_make = {
          \ 'kinds':[
            \ 'm:macros',
            \ 't:targets'
          \ ]
        \}
        let g:tagbar_type_markdown = {
          \ 'ctagstype' : 'markdown',
          \ 'kinds' : [
            \ 'h:Heading_L1',
            \ 'i:Heading_L2',
            \ 'k:Heading_L3'
          \ ]
        \ }
        " }}}
    " }}}
" }}}
"
"
" BACKUPS AND UNDOS: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry
" }}}
" CUSTOM FUNCTIONS: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Create the `tags` file (dependency: ctags)
command! MakeTags !ctags -R
"     TAG JUMPING: {{{
"         - Use ^] to jump to tag under cursor
"         - Use g^] for ambiguous tags
"         - Use ^t to jump back up the tag stack
"         - Use ^w-^] for Tag Split
"     }}}

"     AUTOCOMPLETE: {{{
"         - ^x^n for JUST this file
"         - ^x^f for filenames
"         - ^x^] for tags
"         - ^n for anything specified by the 'complete' option
"         - Use ^n and ^p to go back and forth in the suggestion list
"     }}}

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" toggle between number and relativenumber
function! <SID>ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
" }}}
" LEADER SHORTCUTS: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch between relative and absolute line numbers
nnoremap <leader>t :call <SID>ToggleNumber()<CR>
"
" Remove Windows ^M when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
map <leader>cn :cnext<cr>
map <leader>cp :cprevious<cr>
nmap <leader>dg :diffget<CR>
nmap <leader>dt :windo difft<CR>

" }}}

" No spell check at new file
au BufNewFile,BufReadPost,FilterReadPost,FileReadPost * set nospell
" vim:foldmethod=marker:foldlevel=0
if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
    let base16colorspace=256
    colorscheme base16-$BASE16_THEME
endif
