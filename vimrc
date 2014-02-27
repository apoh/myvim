""filetype off
""call pathogen#infect()
""call pathogen#incubate()
""syntax on
""filetype plugin indent on
""call pathogen#helptags()

Bundle kien/ctrlp.vim
Bundle tpope/vim-fugitive
Bundle vim-scripts/grep.vim
Bundle sjl/gundo.vim
Bundle vim-scripts/Mark--Karkat
Bundle Shougo/neocomplcache
Bundle scrooloose/nerdtree
Bundle vim-scripts/py-coverage
Bundle alfredodeza/pytest.vim
Bundle klen/python-mode
Bundle wlangstroth/vim-racket
Bundle kien/rainbow_parentheses.vim
Bundle scrooloose/syntastic
Bundle majutsushi/tagbar
Bundle vim-php/tagbar-phpctags.vim
Bundle marijnh/tern_for_vim
Bundle joonty/vdebug
Bundle bling/vim-airline
Bundle altercation/vim-colors-solarized
Bundle Lokaltog/vim-easymotion
Bundle xolox/vim-easytags
Bundle airblade/vim-gitgutter
Bundle jcf/vim-latex
Bundle vim-ruby/vim-ruby
Bundle derekwyatt/vim-scala
Bundle xolox/vim-misc
Bundle Shougo/vimshell.vim

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
syntax on
set synmaxcol=300
set tags=./.tags;,~/.vimtags
filetype plugin indent on
" Reload files when they are changed by another process.
set autoread
au FileType scala setl sw=2 sts=2 et
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

colorscheme solarized

set background=dark

let mapleader = ","
nmap <leader>g :Grep --exclude=*{pyc,xml,pylint.txt} --exclude-dir={doc,.ropeproject,.git,backend.egg-info} -nR <cword> .<CR>
nmap <leader>fg :Grep -nR function.*<cword> .<CR>
nmap <leader>vd :Gvdiff <CR>
nmap <leader>vb :Gblame <CR>
nmap <leader>vl :Glog<CR>
nmap <leader>vs :Gstatus<CR>
nmap <leader>vc :Gcommit<CR>
nmap <leader>ptf :Pytest file<CR>
nmap <leader>ptm :Pytest method<CR>
nmap <leader>ptc :Pytest class<CR>
nmap <leader>u :GundoToggle<CR>
nmap <leader>t :TagbarToggle<CR>
""nmap <leader>ec :call SwitchPHPCss() <cr>
nmap <leader>cw :% s/\s\+$//gc<cr>

call togglebg#map("<leader>tb")

" tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

command! -nargs=1 FuncGrep :Grep -nR function.*<args> .
command! -nargs=1 RekGrep :Grep -nR <args> .
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
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_enable_phpcs=0
let g:loaded_syntastic_php_phpmd_checker=0
let g:loaded_syntastic_scala_scalac_checker=1
let g:syntastic_python_checkers=['pyflakes', 'pylint', 'pep8']


let g:user_zen_settings = { 'indentation' : '  '}

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"neocomplettion stuff
" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
let g:acp_enableAtStartup = 0
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

let g:pymode_lint = 0
let g:pymode_lint_write = 0
let g:pymode_rope = 1
let g:pymode_folding = 0
" Can have multiply values "pep8,pyflakes,mcccabe"
" Choices are pyflakes, pep8, mccabe, pylint, pep257
let g:pymode_lint_checker = "pyflakes, pylint, pep8"

" Skip errors and warnings
" E.g. "E501,W002", "E2,W" (Skip all Warnings and Errors startswith E2) and etc
let g:pymode_lint_ignore = "E501"

" Pylint configuration file
" If file not found use 'pylintrc' from python-mode plugin directory
"let g:pymode_lint_config = "$HOME/.pylintrc"
""let g:pymode_rope_goto_definition_bind = '<leader>rg'
let g:pymode_rope_goto_definition_cmd = 'e'
""let g:pymode_rope_autoimport_bind = '<leader>rai'

let g:airline_theme='laederon'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
set laststatus=2
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svndoc|.ropeproject|backend.egg-info|node_modules)$',
  \ 'file': '\v\.(pyc)$',
  \ }

let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '__pycache__$[[dir]]', '\.egg']

let g:easytags_dynamic_files = 1
let g:easytags_events = ['BufWritePost']
