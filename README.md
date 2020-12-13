# shellcheck-extras.vim

This plugin provides extra utilities for working with shellcheck.

## Commands

- `:ShellcheckSuppressWarnings` - Suppress all warnings for the current line.

## Install

Requires either ALE or Syntastic to be installed and configured for shellcheck.

```vim
" Dein
call dein#add('b0o/shellcheck-extras.vim')

" NeoBundle
NeoBundle 'b0o/shellcheck-extras.vim'
```

## TODO

- [ ] convert to ftplugin
- [ ] Support running shellcheck directly without the use of ALE/Syntastic
- [ ] test with Syntastic
- [ ] docs

## Credit

Based on [shellcheck.vim](https://github.com/kawaz/shellcheck.vim) by [@kawaz](https://twitter.com/kawaz).


## License

MIT License

