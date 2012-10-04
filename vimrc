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
filetype on

colorscheme desert

call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


let g:syntastic_enable_phpcs=0
""function! SwitchPHPCss()
""    if g:syntastic_enable_phpcs==0
""        let g:syntastic_enable_phpcs=1
""    else
""        let g:syntastic_enable_phpcs=0
""    endif
""endfunction


let mapleader = ","
nmap <leader>g :Grep -nR <cword> .<CR>
nmap <leader>fg :Grep -nR function.*<cword> .<CR>
nmap <leader>l :FufFile **/<CR>
nmap <leader>fb :FufBuffer <CR>
nmap <leader>vd :Gvdiff <CR>
nmap <leader>vb :Gblame <CR>
nmap <leader>vl :Glog<CR>
""nmap <leader>ec :call SwitchPHPCss() <cr>
nmap <leader>cw :% s/\s\+$//gc<cr>


function! TestFoo()
endfunction

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


syntax on

imap <C-o> ^:set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i

" <C-x-o> is magic :)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
set colorcolumn=120
highlight ColorColumn ctermbg=lightgrey guibg=gray21

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

imap <C-o> ^:set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i

""" onlye with syntastic
function! CheckPHPCsCss()
    let makeprg = "php coin/start_analyzing.php -type=css -phpcs-outputfilter=vi -path=".shellescape(expand('%'))
    let errorformat= '%E%f | %l| ERROR | %m,%W%f | %l| WARNING | %m'
    let loclist = SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
    return loclist
endfunction

nmap ,sc :call CheckPHPCsCss() <cr>
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
let defaultvirtualenv = $HOME . "/Envs/env2"

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

