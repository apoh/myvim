if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

filetype plugin indent on

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'vim-scripts/Mark--Karkat'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-scripts/py-coverage'
NeoBundle 'alfredodeza/pytest.vim'
NeoBundle 'klen/python-mode'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'vim-php/tagbar-phpctags.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'jcf/vim-latex'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'xolox/vim-misc'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Valloric/YouCompleteMe', {'build' : {'unix' : './install.sh --clang-completer'}}
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'dirkwallenstein/vim-localcomplete'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'othree/javascript-libraries-syntax.vim'
" NeoBundle 'Raimondi/delimitMate'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'matthewsimo/angular-vim-snippets'
NeoBundle 'rking/ag.vim'
NeoBundle 'junkblocker/patchreview-vim'
NeoBundle 'codegram/vim-codereview'

filetype plugin indent on

NeoBundleCheck
call neobundle#end()

set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set hlsearch
set encoding=utf-8
set expandtab
set directory=~/.vimswap
set nu
set guioptions=gmrLtT
set cursorline
set cursorcolumn
set mouse=a
syntax enable
set synmaxcol=300
set textwidth=120
set tags=./.tags;,~/.vimtags
set autoread
au FileType scala setl sw=2 sts=2 et
autocmd! BufNewFile,BufRead *.raml set filetype=yaml
au FileType yaml setl sw=2 sts=2 et
au FileType javascript setl sw=2 sts=2 et

au BufNewFile,BufRead *.ejs set filetype=html

augroup checktime
    au!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter        * silent! checktime
        autocmd CursorHold      * silent! checktime
        autocmd CursorHoldI     * silent! checktime
        "these two _may_ slow things down. Remove if they do.
        autocmd CursorMoved     * silent! checktime
        autocmd CursorMovedI    * silent! checktime
    endif
augroup END
filetype on

""colorscheme desert
set t_Co=256
set background=dark
colorscheme solarized

let mapleader = ","
let Grep_Default_Options = '-nIr --exclude=\*{pyc,xml,pylint.txt,coveragerc,.tags} --exclude-dir={doc,.ropeproject,.git,\*.egg-info,__pycache__,\*.egg,node_modules,vendor,build,htmlcov}'
nmap <leader>g :Ag <cword> .<CR>
nmap <leader>fg :Ag function.*<cword> .<CR>
nmap <leader>vd :Gvdiff <CR>
nmap <leader>vb :Gblame <CR>
nmap <leader>vl :Glog<CR>
nmap <leader>vs :Gstatus<CR>
nmap <leader>vc :Gcommit<CR>
nmap <leader>ptf :Pytest file<CR>
nmap <leader>ptm :Pytest method<CR>
nmap <leader>plq :let g:pymode_lint_cwindow = 1<CR>
nmap <leader>pln :let g:pymode_lint_cwindow = 0<CR>
nmap <leader>ptc :Pytest class<CR>
nmap <leader>u :GundoToggle<CR>
nmap <leader>t :TagbarToggle<CR>
""nmap <leader>ec :call SwitchPHPCss() <cr>
nmap <leader>cw :% s/\s\+$//gc<cr>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

call togglebg#map("<leader>tb")

" tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-PageUp> :bnext<CR>
nnoremap <C-PageDown>   :bprevious<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
inoremap <C-ß>     <Esc>:CtrlPBuffer<CR>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

nnoremap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<CR>

command! -nargs=1 FuncGrep :Grep function.*<args> .
command! -nargs=1 RekGrep :Grep <args> *
map <C-n> :NERDTreeToggle<CR>

" <C-x-o> is magic :)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType scala set omnifunc=scalacomplete#CompleteTags
set completeopt-=preview

" For Ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"set colorcolumn=80
set colorcolumn=120
set splitbelow
set splitright

if has("autocmd")
  augroup phpfiles
    autocmd BufRead,BufNewFile *.php,*.module,*.theme,*.inc,*.install,*.info,*.engine,*.profile,*.test,*.class set filetype=php
  augroup END
endif

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0
let g:syntastic_aggregate_errors = 1
let g:syntastic_loc_list_height=5
let g:loaded_syntastic_php_phpmd_checker=1
let g:loaded_syntastic_php_phpcs_checker = 1
let g:loaded_syntastic_scala_scalac_checker=1
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
let g:syntastic_javascript_checkers=['jscs', 'jshint']


let g:user_zen_settings = { 'indentation' : '  '}

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:pymode_lint = 1
let g:pymode_lint_write = 1
let g:pymode_rope = 0
let g:pymode_folding = 0
let g:pymode_lint_cwindow = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']

" Skip errors and warnings
" E.g. "E501,W002", "E2,W" (Skip all Warnings and Errors startswith E2) and etc
let g:pymode_lint_ignore = "E501"

" Pylint configuration file
" If file not found use 'pylintrc' from python-mode plugin directory
"let g:pymode_lint_config = "$HOME/.pylintrc"
""let g:pymode_rope_goto_definition_bind = '<leader>rg'
let g:pymode_rope_goto_definition_cmd = 'e'
""let g:pymode_rope_autoimport_bind = '<leader>rai'
let g:pymode_options_colorcolumn = 0

let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:jedi#goto_assignments_command = 'leader<rg>'
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0

let g:airline_theme='laederon'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
set laststatus=2

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](.git|.hg|.svndoc|.ropeproject|backend.egg-info|node_modules|coverage|vendor|build|htmlcov)$',
  \ 'file': '\v(.pyc|TEST.*xml)$',
  \ }

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '__pycache__$[[dir]]', '\.egg']

"  Parentheses colours using Solarized
let g:rbpt_colorpairs = [
  \ [ '13', '#6c71c4'],
  \ [ '5',  '#d33682'],
  \ [ '1',  '#dc322f'],
  \ [ '9',  '#cb4b16'],
  \ [ '3',  '#b58900'],
  \ [ '2',  '#859900'],
  \ [ '6',  '#2aa198'],
  \ [ '4',  '#268bd2'],
  \ ]

"" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"

let g:used_javascript_libs = 'underscore,angularjs,angularui,jasmine'
let g:ycm_path_to_python_interpreter = '/usr/bin/python2.7'

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", "translate", "tracking", "trimming empty"]

let g:angular_source_directory = 'src'

map <Space> <Plug>(easymotion-prefix)
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

set backspace=indent,eol,start
