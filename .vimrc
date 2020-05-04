set packpath^=~/.vim
function! MapTex()
    imap á \'a
    imap é \'e
    imap í \'{\i}
    imap ó \'o
    imap ú \'u
    imap Á \'A
    imap É \'E
    imap Í \'I
    imap Ó \'O
    imap Ú \'U
    imap ü \"u
    imap Ü \"U
    imap ¡ \textexclamdown{}
    imap ¿ \textquestiondown{}
    imap ñ \~n
    imap Ñ \~N
    if empty(v:servername) && exists('*remote_startserver')
      call remote_startserver('VIM')
    endif
    call deoplete#custom#var('omni', 'input_patterns', {
        \'tex': g:vimtex#re#deoplete
        \})
endfunction
function! MapPhp()
    imap .. =>
    imap -- ->
endfunction
function! MapJs()
    imap ,, =>
endfunction
function! MapErl()
    imap -- ->
    imap .. =>
    imap << <<>><left><left>
endfunction
function! MapHtml()
    " imap á &aacute;
    " imap é &eacute;
    " imap í &iacute;
    " imap ó &oacute;
    " imap ú &uacute;
    " imap Á &Aacute;
    " imap É &Eacute;
    " imap Í &Iacute;
    " imap Ó &Oacute;
    " imap Ú &Uacute;
    " imap ü &uuml;
    " imap Ü &Uuml;
    " imap ¡ &iexcl;
    " imap ¿ &iquest;
    " imap ñ &ntilde;
    " imap Ñ &Ntilde;
    imap ª &ordf;
    imap º &ordm;
    imap € &euro;
endfunction
function! MapEmmet()
  let g:user_emmet_install_global = 0
  let g:user_emmet_leader_key = '<C-y>'
  let g:user_emmet_complete_tag = 1
  let g:user_emmet_settings = {'indentation': '  ','variables':{'lang': 'es','locale':'es-ES'}}
  let g:user_emmet_expandabbr_key = '<C-y>,'
  let g:user_emmet_expandword_key = '<C-y>;'
  let g:user_emmet_update_tag = '<C-y>u'
  let g:user_emmet_balancetaginward_key = '<C-y>d'
  let g:user_emmet_balancetagoutward_key = '<C-y>D'
  let g:user_emmet_next_key = '<C-y>n'
  let g:user_emmet_prev_key = '<C-y>N'
  let g:user_emmet_imagesize_key = '<C-y>i'
  let g:user_emmet_togglecomment_key = '<C-y>/'
  let g:user_emmet_splitjointag_key = '<C-y>j'
  let g:user_emmet_removetag_key = '<C-y>k'
  let g:user_emmet_anchorizeurl_key = '<C-y>a'
  let g:user_emmet_anchorizesummary_key = '<C-y>A'
  let g:user_emmet_mergelines_key = '<C-y>m'
  let g:user_emmet_codepretty_key = '<C-y>c'
endfunction
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
function! AppendModeline()
    let l:modeline = printf(" vim: set fdm=%s ts=%d sw=%d tw=%d %set :",
                \ &foldmethod, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
function! TrailingWhitespace()
  normal mZ
  let l:chars = col("$")
  %s/\s\+$//e
  if (line("'Z") != line(".")) || (l:chars != col("$"))
    echo "Trailing whitespace stripped\n"
  endif
  normal `Z
endfunction
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

let maplocalleader = ","
let mapleader = ","
if has('nvim')
    if exists(':tnoremap')
        tnoremap <Esc> <C-\><C-n>
        tnoremap <C-v><Esc> <Esc>
    endif
endif
let s:hidden_all = 0

filetype on
syntax on
filetype plugin on
filetype indent on
set viminfo=""
set lazyredraw
set helplang=es
set showcmd
set undofile
set undodir=~/.vim/.undo//
set exrc
set writebackup
set backup
set backupdir=~/.vim/.bak//
set swapfile
set directory=~/.vim/.swap//
set expandtab
set go-=T
set go-=r
set go-=m
set tabstop=4
set cindent
set showmatch
set updatetime=1000
set ignorecase
set smartcase
set nohlsearch
set cursorline
set ruler
set autoindent
set autowrite
set autoread
set nu
set modeline
set scrolloff=5
set modelines=1
set sw=4
set spl=es "spelling
set textwidth=82
set laststatus=2
set grepprg=grep\ -nH\ $*
set wildmenu
set cpo-=<
set nocompatible
set scrolloff=5
set encoding=utf-8
set foldmethod=syntax
set foldnestmax=10
set foldlevelstart=4   " open most folds by default
set foldlevel=0
set pumheight=15
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set guifont=Fira\ Code\ Light\ 12
set tags=~/.vim/tags
set background=dark
colorscheme gruvbox
let &colorcolumn=join(range(83,999),",")
let g:deoplete#enable_at_startup = 1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let wiki = { 'scratch_path': 'notas','path': '~/Documentos/wiki',}
let notas = { 'scratch_path': 'notas', 'path': '~/Documentos',}
let g:riv_projects = [wiki, notas]
let g:riv_default_path = '~/Documentos'
let g:riv_month_names = 'Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre'
let g:xml_no_html = 1
let g:vimtex_fold_enabled=1
let g:vimsyn_folding='af'
let g:rust_fold = 1
let g:javaScript_folding=1
let g:xml_syntax_folding = 1
let g:php_folding = 1
let g:erlang_folding = 1
let g:perl_fold = 1
let g:tex_flavor='latex'
let g:solarized_termcolors=256
" Goyo Settings
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
let tlist_haxe_settings='haxe;f:function;v:variable;c:class;i:interface;p:package'
let loaded_matchit = 1
let g:session_autosave='yes'
let g:session_autoload='no'
let g:tagbar_autoclose = 0
let g:tagbar_width = 30
let g:tagbar_left = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:mundo_width = 40
let g:mundo_preview_height = 10
let g:yapf_style = "pep8"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "misnips"]
let g:UltiSnipsExpandTrigger = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:rustfmt_autosave = 1
let g:ale_fix_on_save = 1
let g:ale_open_list = 1
let g:ale_list_vertical = 1
let g:ale_completion_enabled = 1
let g:ctags_statusline=1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 1
let g:generate_tags=1
let g:haddock_browser='/usr/bin/firefox'
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
" Debugger remap
let g:vdebug_keymap = {
    \   "run" : "<leader><F5>",
    \   "set_breakpoint" : "<leader><F10>",
    \}
" Tex settings
let g:polyglot_disabled = ['latex']
let g:vimtex_format_enabled = 1
let g:vimtex_view_method = 'mupdf'
let g:sneak#label = 1
" Centrar la siguiente coincidencia en la pantalla
nnoremap n nzz
nnoremap N Nzz
" Gstatus
nnoremap <silent> <leader>g :G<cr>
" Goyo
nnoremap <silent> <leader>z :Goyo<cr>
cmap w!! w !sudo tee % >/dev/null
nnoremap <F2> :TagbarToggle<cr>
nnoremap <F3> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <F4> :MundoToggle<CR>
nnoremap <F5> :execute "noautocmd vimgrep /\\<" . expand("<cword>") . "\\>/ **/*"<CR>
nnoremap <silent> <leader>nn :call ToggleVExplorer()<cr>
nnoremap <F10> :buffers<CR>:buffer<Space>
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
nnoremap <S-h> :call ToggleHiddenAll()<CR>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
vnoremap < <gv
vnoremap > >gv
" easier formatting of paragraphs
vmap Q gq
nmap Q gqap
" arrow movement, resize splits.
nnoremap <C-M-j> :resize +2<CR>
nnoremap <C-M-k> :resize -2<CR>
nnoremap <C-M-l> :vertical resize +2<CR>
nnoremap <C-M-h> :vertical resize -2<CR>
nnoremap <leader>ww :vertical resize 89<CR>
" Quickly open/reload vim
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" dark or ligth colorscheme
nnoremap <leader>bd :colorscheme gruvbox <bar> set background=dark<cr>
nnoremap <leader>bl :colorscheme solarized <bar> set background=light<cr>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Enable omni completio autocmd FileType python setlocal omnifunc=python#complete
" autocmd FileType python setlocal omnifunc=#complete
" autocmd VimEnter * nested :call tagbar#autoopen()
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au BufNewFile,BufRead *.hx,*.as set filetype=haxe
    au BufNewFile,BufRead *.ctp set filetype=html
    au BufNewFile,BufRead *.mxml set filetype=mxml
    au BufNewFile,BufRead *.asm,*.s,*.inc,*.fasm set filetype=fasm
    au BufNewFile,BufRead *.less set filetype=css
    au FileType css setlocal omnifunc=csscomplete#CompleteCSS
    au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    au FileType html,markdown,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
    au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au FileType html,xhtml set equalprg=tidy\ -icmq\ -utf8\ -w\ 80\ -asxml | compiler tidy
    au FileType html,xhtml call MapHtml()
    au FileType php,ctp call MapPhp()
    au FileType erlang call MapErl()
    au FileType javascript call MapJs()
    au FileType tex call MapTex()
    au FileType php set omnifunc=phpcomplete#CompletePHP
    au FileType xml,svg set equalprg=xmllint\ --format\ -
    au BufReadPre *.tex let b:vimtex_main = 'main.tex'
    au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=4 expandtab
    au BufRead,BufNewFile *.R setf r
    au BufEnter *.hs compiler ghc
    au FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
    au FileType python setl equalprg=yapf
    au BufRead,BufNewFile *.css,*.html,*.less,*.xhtml call MapEmmet()
    au User GoyoEnter Limelight
    au User GoyoLeave Limelight!
    au BufWritePre * %s/\s\+$//e
    au BufWritePost $MYVIMRC source $MYVIMRC
    au WinEnter * vertical resize 89
endif " has("autocmd")

" vim: set ts=5 sw=4 tw=82 et foldlevel=0:
