# shellcheck.vim

## Install

Requires either ALE or Syntastic to be installed and configured for shellcheck.

```vim
" Dein
call dein#add('b0o/shellcheck.vim')

" NeoBundle
NeoBundle 'b0o/shellcheck.vim'
```

## Commands

- `:ShellcheckSuppressWarnings` - Suppress all warnings for the current line.

## Credit

Based on [shellcheck.vim](https://github.com/kawaz/shellcheck.vim) by [@kawaz](https://twitter.com/kawaz).

## TODO

- [ ] Support running shellcheck directly without the use of ALE/Syntastic

## License

MIT License
