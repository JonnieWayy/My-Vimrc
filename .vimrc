syntax on
filetype off                  " required

" set termguicolor

set ts=4
set visualbell
set expandtab
set tabstop=4
set shiftwidth=4
set nocompatible              " be iMproved, required
set mouse=a
set cursorline
set cursorcolumn
set autoindent
set ruler
set tabstop=4
set softtabstop=4
set showmatch
set number
set relativenumber
set linebreak
set wrap
set showcmd
set wildmenu
set ignorecase
set smartcase
set hlsearch
exec "nohlsearch"
set incsearch
set showmatch
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936,iso-8859-1
set backspace=indent,eol,start
set autochdir
set nobackup
set scrolloff=5
set guifont=DroidSansMono\ Nerd\ Font\ 11
" set clipboard=unnamedplus

" set guioptions-=m
" set guioptions-=T

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd BufNewFile,BufRead *.tex set spell

" 基于缩进或语法进行代码折叠
set foldmethod=indent
" set foldmethod=syntax
" 启动 vim 时关闭折叠代码, za改变当前，zM关闭所有，zR打开所有
set nofoldenable

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim

call plug#begin('~/.vim/plugged')

Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

Plug 'tpope/vim-surround'

Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
autocmd BufWritePre *.dart* DartFmt

Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp', 'h']}

" Plug 'ajmwagar/vim-deus'
" set t_Co=256
" set termguicolors
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" set background=dark    " Setting dark mode
" let g:deus_termcolors=256

" go 主要插件
Plug 'fatih/vim-go', { 'tag': '*' }
" go 中的代码追踪，输入 gd 就可以自动跳转
Plug 'dgryski/vim-godef'

let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
let g:godef_split=2

" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" let g:ycm_python_binary_path = '/usr/bin/python'
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_complete_in_comments = 1
" let g:ycm_complete_in_strings = 1
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 0
" nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap g/ :YcmCompleter GetDoc<CR>
" nnoremap gt :YcmCompleter GetType<CR>
" nnoremap gr :YcmCompleter GoToReferences<CR>

Plug 'theniceboy/vim-calc'

" ============================= Coc-Configs ================================
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Note: you have to remap <cr> to make sure it confirm completion when pum is visible.
" Note: \<C-g>u is used to break undo level.

" To make <cr> select the first completion item and confirm the completion when no item has been selected:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" To make coc.nvim format your code on <cr>, use keymap:
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap keys for gotos
nnoremap <LEADER>gd <Plug>(coc-definition)
nnoremap <LEADER>gy <Plug>(coc-type-definition)
nnoremap <LEADER>gi <Plug>(coc-implementation)
nnoremap <LEADER>gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" ============================= Coc-Configs ================================

Plug 'dhruvasagar/vim-table-mode'
" Use this option to define the table corner character
let g:table_mode_corner = '|'
" Use this option to define the delimiter which used by
let g:table_mode_delimiter = ' '


Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
let g:mkdp_path_to_chrome = "qutebrowser"
" let g:mkdp_auto_start = 0
" let g:mkdp_auto_close = 1
" let g:mkdp_refresh_slow = 0
" let g:mkdp_command_for_global = 0
" let g:mkdp_open_to_the_world = 0
" let g:mkdp_open_ip = ''
" let g:mkdp_echo_preview_url = 0
" let g:mkdp_browserfunc = ''
" let g:mkdp_preview_options = {
    " \ 'mkit': {},
    " \ 'katex': {},
    " \ 'uml': {},
    " \ 'maid': {},
    " \ 'disable_sync_scroll': 0,
    " \ 'sync_scroll_type': 'middle',
    " \ 'hide_yaml_meta': 1
    " \ }
" let g:mkdp_markdown_css = ''
" let g:mkdp_highlight_css = ''
" let g:mkdp_port = ''
" let g:mkdp_page_title = '「${name}」'
nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode

Plug 'kshenoy/vim-signature'
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "dm-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "dm/",
        \ 'PurgeMarkers'       :  "dm?",
        \ 'GotoNextLineAlpha'  :  "m<LEADER>",
        \ 'GotoPrevLineAlpha'  :  "",
        \ 'GotoNextSpotAlpha'  :  "m<LEADER>",
        \ 'GotoPrevSpotAlpha'  :  "",
        \ 'GotoNextLineByPos'  :  "",
        \ 'GotoPrevLineByPos'  :  "",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "",
        \ 'GotoPrevMarker'     :  "",
        \ 'GotoNextMarkerAny'  :  "",
        \ 'GotoPrevMarkerAny'  :  "",
        \ 'ListLocalMarks'     :  "m/",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

Plug 'junegunn/goyo.vim'
nnoremap <LEADER>gy :Goyo<CR>

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

Plug 'mbbill/undotree'
let g:undotree_DiffAutoOpen = 0
set undodir=~/.undodir/
set undofile
nnoremap tt :UndotreeToggle<CR>

Plug 'scrooloose/nerdtree'
let g:NERDTreeWinPos='left'
let g:NERDTreeSize=30
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeHidden=0
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
map ff :NERDTreeToggle<CR>
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDSpaceDelims=1
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = "l"
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "n"
let NERDTreeMapChangeRoot = "y"

" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'crusoexia/vim-dracula'
let g:dracula_italic = 1

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set laststatus=2
set t_Co=256
set encoding=utf-8
set langmenu=zh_CN.UTF-8
" let g:airline_theme='badwolf'
let g:airline_theme='bubblegum'
set background=dark
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
nnoremap <C-M> :bn<CR>
nnoremap <C-N> :bp<CR>

Plug 'lpinilla/vim-codepainter'

Plug 'jiangmiao/auto-pairs'

Plug 'mattn/emmet-vim'

Plug 'ryanoasis/vim-devicons'

" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" Plug 'honza/vim-snippets'
" Plug 'KeitaNakamura/tex-conceal.vim'
" set conceallevel=1
" let g:tex_conceal='abdmg'
" hi Conceal ctermbg=none

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='okular'
let g:tex_indent_items=0
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" Plug 'sirver/ultisnips'
" let g:UltiSnipsExpandTrigger = '<tab>'
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'Yggdroot/indentLine'
" let g:indentLine_setColors = 0
let g:indentLine_char = '┊'
" let g:indentLine_char_list = ['|', '¦', '┆', '┊']

call plug#end()

filetype plugin indent on    " require

colorscheme dracula

let mapleader=" "

nnoremap <F5>   <Esc>:w<CR>:!/opt/anaconda/bin/python3 %<CR>
nnoremap <C-F5>   <Esc>:w<CR>:!python3 %<CR>

nnoremap <F6>   <Esc>:w<CR>:!g++ -std=c++11 % -o /tmp/a.out && /tmp/a.out<CR>
nnoremap <C-F6> <Esc>:w<CR>:!g++ -std=c++11 -g % -o /tmp/a.out && gdb /tmp/a.out<CR>
nnoremap <F7>   <Esc>:w<CR>:!g++ -std=c++11 %<CR>

nnoremap <LEADER>fr :!flutter<SPACE>run<CR>
nnoremap <LEADER>fp :!flutter<SPACE>packages<SPACE>get<CR>
nnoremap <LEADER>fe8 :!flutter<SPACE>emulators<SPACE>--launch<SPACE>Nexus_6_API_27<CR><CR>
nnoremap <LEADER>fe1 :!flutter<SPACE>emulators<SPACE>--launch<SPACE>Nexus_6P_API_30<CR><CR>

nnoremap <LEADER>m :call Calc()<CR>

nnoremap <LEADER><CR> :nohlsearch<CR>

inoremap <C-a> <esc>la

inoremap <C-u> <esc>gUiwea
inoremap jk <esc>
inoremap kj <esc>

nnoremap s :w<CR>
nnoremap S :wq<CR>
nnoremap Q :q<CR>

nnoremap <LEADER>sl :set splitright<CR>:vsplit<CR>
nnoremap <LEADER>sh :set nosplitright<CR>:vsplit<CR>
nnoremap <LEADER>sk :set nosplitbelow<CR>:split<CR>
nnoremap <LEADER>sj :set splitbelow<CR>:split<CR>

nnoremap <LEADER>l <C-w>l
nnoremap <LEADER>k <C-w>k
nnoremap <LEADER>j <C-w>j
nnoremap <LEADER>h <C-w>h

nnoremap <LEADER><up> :res -5<CR>
nnoremap <LEADER><down> :res +5<CR>
nnoremap <LEADER><left> :vertical resize+5<CR>
nnoremap <LEADER><right> :vertical resize-5<CR>

nnoremap <LEADER>nr :set norelativenumber<CR>
nnoremap <LEADER>rr :set relativenumber<CR>

nnoremap tu :tabe<CR> 
nnoremap tn :-tabnext<CR>
nnoremap tm :+tabnext<CR>

nnoremap <LEADER>sv <C-w>t<C-w>H
nnoremap <LEADER>sh <C-w>t<C-w>K

nnoremap <LEADER>se :source %<CR>

nnoremap <C-h> i**<Esc>
inoremap <C-h> **

nnoremap <LEADER>fd /\(\<\w\+\>\)\_s*\l
nnoremap <LEADER>sc :set spell!<CR>
noremap <C-x> ea<C-x>s
inoremap <C-x> <Esc>ea<C-x>s
inoremap <C-l> \\(\\)<Esc>hhha

" map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l
noremap tx :r !figlet 

nnoremap <LEADER>ga :!git add %<CR><CR>
nnoremap <LEADER>gc :!git commit -m 
nnoremap <LEADER>gu :!git commit -m "Update"<CR><CR>
nnoremap <LEADER>gp :!git push -u origin master<CR>

inoremap <C-d> <Esc>ddO<Esc>

nnoremap <LEADER>hd ggi"""<CR>@author:<SPACE>Jonathan<SPACE>Wang<CR>@coding:<SPACE>utf-8<CR>@environment:<SPACE>Manjaro<SPACE>18.1.5<SPACE>Juhraya<CR>@date:<Esc>o<CR><Esc>i"""<Esc>

nnoremap <LEADER>ct ocategories:<CR>tags:<Esc>
