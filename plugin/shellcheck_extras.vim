let s:save_cpo = &cpoptions
set cpoptions&vim

command! -range ShellcheckSuppressWarnings :<line1>,<line2>call shellcheck_extras#SuppressWarnings()

let &cpoptions = s:save_cpo
unlet s:save_cpo
