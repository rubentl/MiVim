set packpath^=~/.vim

function! MapPhp()
    imap ,, =>
    imap -- ->
endfunction

function! MapJs()
    imap ,, =>
endfunction

function! MapErl()
    imap -- ->
    imap ,, =>
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
command! TrailingWhitespace call TrailingWhitespace()

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

function DeleteHiddenBuffers() " Vim with the 'hidden' option
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction
command! DeleteHiddenBuffers call DeleteHiddenBuffers()

" Insert a newline after each specified string (or before if use '!').
" If no arguments, use previous search.
function! LineBreakAt(bang, ...) range
  let save_search = @/
  if empty(a:bang)
    let before = ''
    let after = '\ze.'
    let repl = '&\r'
  else
    let before = '.\zs'
    let after = ''
    let repl = '\r&'
  endif
  command! -bang -nargs=* -range LineBreakAt <line1>,<line2>call LineBreakAt('<bang>', <f-args>)

  let pat_list = map(deepcopy(a:000), "escape(v:val, '/\\.*$^~[')")
  let find = empty(pat_list) ? @/ : join(pat_list, '\|')
  let find = before . '\%(' . find . '\)' . after
  " Example: 10,20s/\%(arg1\|arg2\|arg3\)\ze./&\r/ge
  execute a:firstline . ',' . a:lastline . 's/'. find . '/' . repl . '/ge'
  let @/ = save_search
endfunction
function! CommonTheme()
  let g:gruvbox_material_better_performance = 1
  let g:gruvbox_material_enable_bold = 1
  let g:gruvbox_material_enable_italic = 1
  let g:gruvbox_material_cursor = 'purple'
  let g:gruvbox_material_diagnostic_line_highlight = 1
  let g:gruvbox_material_palette = 'material'
  " let g:gruvbox_material_transparent_background = 1
endfunction
function! ThemeLight()
  call CommonTheme()
  let g:gruvbox_material_background = 'soft'
  set background=light
  colorscheme gruvbox-material
endfunction
function! ThemeDark()
  call CommonTheme()
  let g:gruvbox_material_background = 'hard'
  set background=dark
  colorscheme gruvbox-material
endfunction
function! MyTabLine()
 let s = ''
 let t = tabpagenr()
 let i = 1
 while i <= tabpagenr('$')
     let buflist = tabpagebuflist(i)
     let winnr = tabpagewinnr(i)
     let s .= '%' . i . 'T'
     let s .= (i == t ? '%1*' : '%2*')
     let s .= ' '
     let s .= i . ')'
     let s .= ' %*'
     let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
     let file = bufname(buflist[winnr - 1])
     let file = fnamemodify(file, ':p:t')
     if file == ''
         let file = '[No Name]'
     endif
     let s .= file
     let i = i + 1
 endwhile
 let s .= '%T%#TabLineFill#%='
 let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
 return s
endfunction
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
" Don't save backups of *.gpg files
set backupskip+=*.gpg
" To avoid that parts of the file is saved to .viminfo when yanking or
" deleting, empty the 'viminfo' option.
set viminfo=
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
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set tags=~/.vim/tags
set stal=2
set tabline=%!MyTabLine()
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" set guifont=Inconsolata\ Condensed\ Light\ 16
set guifont=Iosevka\ Fixed\ SS07\ Light\ 13
" Para las ligaduras de las fuentes
if has('gui_running')
    let g:gtk_nocache=[0x00000000, 0xfc00ffff, 0xf8000001, 0x78000001]
endif
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
let &colorcolumn = join(range(83,999),",")
let s:hidden_all = 0
let maplocalleader = ","
let mapleader = ","
let g:deoplete#enable_at_startup = 1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
let g:xml_no_html = 1
let g:vimsyn_folding='af'
let g:rust_fold = 1
let g:javaScript_folding=1
let g:xml_syntax_folding = 1
let g:php_folding = 1
let g:erlang_folding = 1
let g:perl_fold = 1
let g:solarized_termcolors=256
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
let g:loaded_netrw = 1
let g:vifm_replace_netrw = 1
let g:vifm_embed_split = 1
let g:mundo_width = 40
let g:mundo_preview_height = 10
let g:yapf_style = "pep8"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "misnips"]
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:rustfmt_autosave = 1
let g:ale_fix_on_save = 1
let g:ale_open_list = 1
let g:ale_list_vertical = 1
let g:ale_completion_enabled = 1
let g:ale_fixers = {
    \ 'javascript': ['prettier'],
    \ 'css': ['prettier'],
    \ 'html': ['prettier'],
    \ 'php': ['phpcbf'],
    \ 'python': ['yapf']
    \}
" ale linters config
let g:ale_linters = {
    \ 'javascript': ['prettier'],
    \ 'css': ['prettier'],
    \ 'html': ['prettier'],
    \ 'python': ['flake8', 'pylint'],
    \ 'php': ['phpcbf']
    \}

let g:ctags_statusline=1
let g:airline_theme = 'gruvbox_material'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 1
let g:generate_tags=1
let g:haddock_browser='/usr/bin/qutebrowser'
" Debugger remap
let g:vdebug_keymap = {
    \   "run" : "<leader><F5>",
    \   "set_breakpoint" : "<leader><F10>",
    \}
let g:sneak#label = 1
let g:bookmark_auto_save_file = $HOME . "/.vim/bookmarks"
let g:bookmark_center = 1
" Cambio los atajos de teclado que trae por defecto bookmarks.
let g:bookmark_no_default_key_mappings = 1
nnoremap <Leader>mt :BookmarkToggle<cr>
nnoremap <Leader>ma :BookmarkAnnotate<cr>
nnoremap <Leader>ms :BookmarkShowAll<cr>
nnoremap <Leader>mn :BookmarkNext<cr>
nnoremap <Leader>mp :BookmarkPrev<cr>
nnoremap <Leader>md :BookmarkClear<cr>
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
let g:tex_flavor='latex'
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
nnoremap <Leader>j :SplitjoinJoin<cr>
nnoremap <Leader>s :SplitjoinSplit<cr>
nnoremap <Leader>tw :TrailingWhitespace<cr>
nnoremap <Leader>dh :DeleteHiddenBuffers<cr>
" Macro para crear un nuevo archivo del diario basado en el activo.
" @s: s de scratch
let @s = "ggVGy\<C-E>scPGzRdd:w\<Enter>gg"
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
" nnoremap <silent> <leader>nn :call ToggleVExplorer()<cr>
nnoremap <silent> <leader>nn :Vifm<cr>
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
nnoremap <leader>bd :call ThemeDark()<cr>
nnoremap <leader>bl :call ThemeLight()<cr>
" Fácil manejo del portapapeles
nnoremap <leader>p  "+p
nnoremap <leader>P  "+P
nnoremap <leader>yy "+yy
vnoremap <leader>y  "+y

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"
inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"
inoremap jj <esc>

if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au BufNewFile,BufRead *.hx,*.as set filetype=haxe
    au BufNewFile,BufRead *.ctp set filetype=html
    au BufNewFile,BufRead *.mxml set filetype=mxml
    au BufNewFile,BufRead *.asm,*.s,*.inc,*.fasm set filetype=fasm
    au BufNewFile,BufRead *.less set filetype=css
    " au FileType css setlocal omnifunc=csscomplete#CompleteCSS
    " au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " au FileType html,markdown,xhtml setlocal omnifunc=htmlcomplete#CompleteTags
    " au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    " au FileType html,xhtml set equalprg=tidy\ -icmq\ -utf8\ -w\ 80\ -asxml | compiler tidy
    au FileType html,xhtml call MapHtml()
    au FileType php,ctp call MapPhp()
    au FileType erlang call MapErl()
    au FileType javascript call MapJs()
    " au FileType php set omnifunc=phpcomplete#CompletePHP
    au FileType xml,svg,html,xhtml set equalprg=xmllint\ --format\ -
    au FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
    au FileType python setl equalprg=yapf
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=4 expandtab foldmethod=indent nofoldenable
    au BufRead,BufNewFile *.R setf r
    au BufRead,BufNewFile *.css,*.html,*.less,*.xhtml call MapEmmet()
    au BufEnter *.hs compiler ghc
    au WinEnter * vertical resize 89
    au User GoyoEnter Limelight
    au User GoyoLeave Limelight!
    au BufWritePre * call TrailingWhitespace()
    au BufWritePost $MYVIMRC source $MYVIMRC
    au VimEnter * call ThemeDark()
augroup encrypted
  au!
  " Disable swap files, and set binary file format before reading the file
  autocmd BufReadPre,FileReadPre *.gpg
    \ setlocal noswapfile bin
  " Decrypt the contents after reading the file, reset binary file format
  " and run any BufReadPost autocmds matching the file name without the .gpg
  " extension
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "'[,']!gpg --decrypt --default-recipient-self" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")
  " Set binary file format and encrypt the contents before writing the file
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self
  " After writing the file, do an :undo to revert the encryption in the
  " buffer, and reset binary file format
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent u |
    \ setlocal nobin
augroup END
endif " has("autocmd")


" vim: set ts=5 sw=4 tw=82 et foldlevel=0:
