if exists("g:loaded_syntastic_notifier_cursor")
    finish
endif
let g:loaded_syntastic_notifier_cursor = 1

if !exists('g:syntastic_echo_current_error')
    let g:syntastic_echo_current_error = 1
endif

let g:SyntasticCursorNotifier = {}

" Public methods {{{1

function! g:SyntasticCursorNotifier.New()
    let newObj = copy(self)
    return newObj
endfunction

function! g:SyntasticCursorNotifier.enabled()
    return syntastic#util#var('echo_current_error')
endfunction

function! g:SyntasticCursorNotifier.refresh(loclist)
    if self.enabled() && !a:loclist.isEmpty()
        call syntastic#log#debug(g:SyntasticDebugNotifications, 'cursor: refresh')
        let b:syntastic_messages = copy(a:loclist.messages(bufnr('')))
        let b:oldLine = -1
        autocmd! syntastic CursorMoved
        autocmd syntastic CursorMoved * call g:SyntasticRefreshCursor()
    endif
endfunction

" @vimlint(EVL103, 1, a:loclist)
function! g:SyntasticCursorNotifier.reset(loclist)
    call syntastic#log#debug(g:SyntasticDebugNotifications, 'cursor: reset')
    autocmd! syntastic CursorMoved
    unlet! b:syntastic_messages
    let b:oldLine = -1
endfunction
" @vimlint(EVL103, 0, a:loclist)

" Private methods {{{1

" The following defensive nonsense is needed because of the nature of autocmd
function! g:SyntasticRefreshCursor()
    if !exists('b:syntastic_messages') || empty(b:syntastic_messages)
        " file not checked
        return
    endif

    if !exists('b:oldLine')
        let b:oldLine = -1
    endif
    let l = line('.')
    if l == b:oldLine
        return
    endif
    let b:oldLine = l

    if has_key(b:syntastic_messages, l)
        call syntastic#util#wideMsg(b:syntastic_messages[l])
    else
        echo
    endif
endfunction

" vim: set sw=4 sts=4 et fdm=marker:
