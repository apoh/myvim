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
set synmaxcol=120
" Reload files when they are changed by another process.
set autoread
au FileType scala setl sw=2 sts=2 et

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
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

colorscheme solarized

set background=dark

let mapleader = ","
nmap <leader>g :Grep -nR <cword> .<CR>
nmap <leader>fg :Grep -nR function.*<cword> .<CR>
nmap <leader>l :FufFile **/<CR>
nmap <leader>b :FufBuffer <CR>
nmap <leader>vd :Gvdiff <CR>
nmap <leader>vb :Gblame <CR>
nmap <leader>vl :Glog<CR>
nmap <leader>vs :Gstatus<CR>
nmap <leader>vc :Gcommit<CR>
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


function! RunPhpcsCss()
    let l:filename=@%
    let l:phpcs_output=system('phpcs --report=csv --standard=PHP_CodeSniffer/bm_css.ruleset.xml --extensions=css '.l:filename)
    let l:phpcs_list=split(l:phpcs_output, "\n")
    unlet l:phpcs_list[0]
    cexpr l:phpcs_list
    cwindow
endfunction
set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"

command! PhpcsCss execute RunPhpcsCss()
command! -nargs=1 FuncGrep :Grep -nR function.*<args> .
command! -nargs=1 RekGrep :Grep -nR <args> .

" <C-x-o> is magic :)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType scala set omnifunc=scalacomplete#CompleteTags

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
set colorcolumn=120
"highlight ColorColumn ctermbg=lightgrey guibg=gray21

""""" TagList Plugin - Ein Klassen/Funktionsbrowser
"" for drupal run
""ctags --langmap=php:.engine.inc.module.theme.php,js:.js --php-kinds=cdfi --languages=php,js --recurse


" Mit <F8> TagList anzeigen
nnoremap <silent> <F8> :TlistToggle<CR>
" Pfad zu den CTags (optional)
" let Tlist_Ctags_Cmd = '/usr/bin/ctags'
" TagList auf der rechten Seite zeigen
let Tlist_Use_Right_Window = 1

if has("autocmd")
  augroup phpfiles
    autocmd BufRead,BufNewFile *.php,*.module,*.theme,*.inc,*.install,*.info,*.engine,*.profile,*.test,*.class set filetype=php
  augroup END
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_enable_phpcs=0
let g:syntastic_javascript_jsl_conf="~/usr/jslint.conf"
let g:syntastic_javascript_jshint_conf="~/usr/jshint.conf"
let g:syntastic_phpcs_disable = 1
let g:loaded_syntastic_scala_scalac_checker = 1


let g:user_zen_settings = { 'indentation' : '  '}

vmap ,cs :call Cssify()<CR>

function! Cssify()
   "yank current visual selection to reg x
   normal gv"xy
   "put new string value in reg x
   " would do your processing here in actual script
   let @x = 'css='.system('cssify "'.@x.'"')
   "re-select area and delete
   normal gvdh
   "paste new string value back in
   normal "xp
endfunction

" Function to activate a virtualenv in the embedded interpreter for
" omnicomplete and other things like that.
function LoadVirtualEnv(path)
    let activate_this = a:path . '/bin/activate_this.py'
    if getftype(a:path) == "dir" && filereadable(activate_this)
        python << EOF
import vim
activate_this = vim.eval('l:activate_this')
execfile(activate_this, dict(__file__=activate_this))
EOF
    endif
endfunction

" Load up a 'stable' virtualenv if one exists in ~/.virtualenv
let defaultvirtualenv = $HOME . "/.envs/amf"

" Only attempt to load this virtualenv if the defaultvirtualenv
" actually exists, and we aren't running with a virtualenv active.
if has("python")
    if empty($VIRTUAL_ENV) && getftype(defaultvirtualenv) == "dir"
        call LoadVirtualEnv(defaultvirtualenv)
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rope https://bitbucket.org/agr/ropevim
let ropevim_vim_completion = 1
let ropevim_extended_complete = 1
let ropevim_enable_shortcuts = 1
let ropevim_guess_project = 1
let g:ropevim_autoimport_modules = ["os.*","traceback","django.*", "xml.etree"]

" Add the virtualenv's site-packages to vim path
function! SetVirtualEnv()
python << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    venv_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, venv_base_dir)
    activate_this = os.path.join(venv_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endfunction
call SetVirtualEnv()
""source $HOME/.vim/plugin/ropevim/ropevim.vim
inoremap <C-Space> <C-R>=RopeCodeAssistInsertMode()<CR>

noremap <leader>rg :RopeGotoDefinition<CR>
noremap <leader>rr :RopeRename<CR>
vnoremap <leader>rm :RopeExtractMethod<CR>
noremap <leader>roi :RopeOrganizeImports<CR>
noremap <leader>rai :RopeAutoImport

noremap <leader>nt :NERDTreeToggle<CR>

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['gray',  'LightSeaGreen'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]


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
