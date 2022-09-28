# Tutorial

To start an interactive shell from the command line run the following command:

```bash
$ iex
```

Or when using PowerShell on Windows:

```powershell
PS > iex.bat --werl
```
* Running iex directly does not work since it is a built-in alias in PowerShell
* The werl flag is recommend when starting iex on windows

A BEAM instance is started with an interactive shell inside of it.

After start-up a prompt is provided where you can enter Elixir expressions:

```elixir
iex(1)> IO.puts("Hello World!")
```

An expression is only evaluated after it is complete, even when entered on multiple lines:

```elixir
iex(1)> IO.puts("Hello 
World!")
```

A running iex shell is very useful to quickly experiment while developing, it is recommended to always have one open.

The shell has a number of features that might help you:

* Autocomplete: `String.[tab]` will list all members of the `String` module
* Documentation: `h String.trim` shows you all information regarding the `trim` function
* `iex filename.exs` will start the shell and load modules defined in the source file `filename.exs`
* `c "filename.exs"` loads the source file `filename.exs` when iex is already running
* `i` lets you inspect values in detail

More information is available [here](https://hexdocs.pm/iex/IEx.Helpers.html#content).

Exiting the shell can be done by using Ctrl-C.