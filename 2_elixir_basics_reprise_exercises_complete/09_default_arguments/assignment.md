# Assignment

The syntax for default parameters in Elixir is as follows:

```elixir
defmodule Example do
    def add(x, y \\ 0) do
        x + y
    end
end
```

## Default Parameter Values and Arity

A detail worth mentioning in case you stumble upon it:
the overloading mechanism can clash with default parameters.
For example,

```elixir
# foo/1
def foo(x), do: ...

# foo/2 with default parameter value
def foo(x, y \\ 5), do: ...
```

The compiler will throw an error in this case, since
it 
cannot determine whether you intend to call `foo/1`
or `foo/2` with the second parameter set to 5.

## Task

Define a function `Language.greeting(salutation, name)` that concatenates the salutation and the name with a space in between.

If the salutation is not provided it should default to `Hello`.

Try to find out how to do string concatenation by yourself.