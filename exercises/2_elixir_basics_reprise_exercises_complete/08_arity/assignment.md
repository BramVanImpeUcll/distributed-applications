# Assignment

`Arity` is the term used to denote the number of arguments a function receives. As an example, the following function has an arity of two since it receives two arguments:

```elixir
defmodule Example do
    def add(x, y) do
        x + y
    end
end
```

In Elixir, a function is identified by its name, the module its defined in and its arity. We can identify the example above as `Example.add/2`. No other function `add` with arity 2 is allowed to exist in the `Example` module.

As an example the following function is a different function, since the tuple (module, name, arity) is different:

```elixir
defmodule Example do
    def add(x) do
        x + 0
    end
end
```

Note that, since Elixir is a dynamic languages, parameters or return types cannot be a part of the function definition.

## Task

Write two functions:

* `Rectangle.area/2`: calculates the area of a Rectangle
* `Rectangle.area/1`: calculates the area of a Square

Make sure to maximize reuse.