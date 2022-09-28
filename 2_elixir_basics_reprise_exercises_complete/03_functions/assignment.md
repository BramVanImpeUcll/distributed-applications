# Assignment

Functions are central in Elixir.

Elixir requires functions to be part of a *module*.
You can compare this with C# or Java: these languages
expect all functions/methods to be part of a class.
This is where the similarities end, however.
Modules are merely a way of bundling
related functions together.

```elixir
defmodule Temperature do
  def kelvin_to_celsius(t) do
    t - 273.15
  end
end
```

Here, we have defined a module named `Temperature`.
It contains a single function, `kelvin_to_celsius`.

Note the following details:

* There is no mention of parameter types nor return type. Elixir is a *dynamically typed language* like Python and JavaScript, but unlike C#, C++ and Java.
* There is no `return`. In Elixir, a function automatically returns the value of the last evaluated expression. In other words, you can imagine
  there's a `return` before `t - 273.15`.
* Defining a module with `def` makes it public, using `defp` makes it private to the module

## Single line functions

If a function definition is short, you can use a special, shorter syntax to define your function:

```elixir
defmodule Temperature do
  def kelvin_to_celsius(t), do: t - 273.15
end
```

## Task

Add a function `celsius_to_kelvin` to the `Temperature` module.

## Running the Tests

To run the tests, run the following command in your shell:

```bash
$ elixir tests.exs
......

Finished in 0.06 seconds (0.06s on load, 0.00s on tests)
6 tests, 0 failures

Randomized with seed 166000
```
