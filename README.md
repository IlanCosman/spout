# Spout

> 100% pure-fish [TAP][]-based test runner.

Spout is a testing framework for [fish]. Tests run in their own sub-shells, so you can set variables, define functions, and modify the environment without hijacking your current session or other tests. There's not even a learning curve—if you know how to use the [`test`][] command, you are ready to use Spout.

## Installation

With [fisher][]:

```console
fisher add IlanCosman/spout
```

## Acknowledgements

- [Fishtape][] - Inspired much of Spout's documentation and design.

[`test`]: https://fishshell.com/docs/current/cmds/test.html
[fish]: https://fishshell.com/
[fisher]: https://github.com/jorgebucaran/fisher
[fishtape]: https://github.com/jorgebucaran/fishtape
[tap]: https://testanything.org/
