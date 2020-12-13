let s:save_cpo = &cpoptions
set cpoptions&vim

function! s:getErrorsForLine(lineno)
  let l:codes = []

  if exists('b:syntastic_private_messages')
    if a:lineno < len(b:syntastic_private_messages)
      for l:msg in b:syntastic_private_messages[a:lineno]
        let l:codes += [matchstr(msg.text, '\[\zsSC[0-9]\+\ze\]$', 0, 1)]
      endfor
    endif

  elseif exists('b:ale_highlight_items')
    for l:item in b:ale_highlight_items
      if l:item['linter_name'] ==? 'shellcheck' && str2nr(l:item['lnum']) == a:lineno
        let l:codes += [l:item['code']]
      endif
    endfor

  else
    " TODO: run shellcheck directly
    throw 'no supported linting plugin detected'
  endif

  return l:codes
endfunction

function! shellcheck_extras#SuppressWarnings()
  let l:lineno = line('.')
  let l:prev_lineno = l:lineno - 1
  let l:prev_line = getline(l:prev_lineno)

  try
    let l:codes = s:getErrorsForLine(l:lineno)
  catch
    echom 'shellcheck.vim: ' . v:exception
    return
  endtry

  if len(l:codes) == 0
    return
  endif

  let l:line_parsed = matchlist(l:prev_line, '\(.*#.*shellcheck.*\)\%(\s\+disable=\)\(\%(\S*\)\%(,\S*\)*\)\(.*\)')

  if len(l:line_parsed) >= 4
    let l:line_head = l:line_parsed[1]
    let l:line_codes = l:line_parsed[2]
    let l:line_tail = l:line_parsed[3]

    let l:joined_codes = extend(l:codes, split(l:line_codes, ','))
    let l:normalised_codes = map(l:joined_codes, { _, c -> substitute(c, '^\(SC\)\?', 'SC', '') })
    let l:disable_codes = uniq(sort(l:normalised_codes))

    let l:newline = l:line_head . ' disable=' . join(l:disable_codes, ',') . l:line_tail
    call setline(l:prev_lineno, l:newline)

  else
    let l:newline = '# shellcheck disable=' . join(l:codes, ',')
    let l:indent = indent('.')

    if l:indent > 0
      let l:newline = getline('.')[0:(l:indent - 1)] . l:newline
    endif

    call append(l:prev_lineno, newline)
  endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
