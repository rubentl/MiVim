let g:vimtex_fold_enabled=1
let g:polyglot_disabled = ['latex']
let g:vimtex_format_enabled = 1
let g:vimtex_view_method = 'mupdf'
let b:vimtex_main = 'main.tex'
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
