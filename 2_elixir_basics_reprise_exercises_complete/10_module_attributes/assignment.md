# Assignment

A module attribute is defined using `@` as follows:

```elixir
defmodule Temperature do
  @conversion_constant  273.15
  
  def kelvin_to_celsius(t) do
    t - @conversion_constant
  end
end
```

You can use defined module attributes throughout the module they are defined in.

Module attributes only exist up to the compilation phase, when they are inlined throughout the module. 

In some special cases, this is called `registering` and allows the module attributes to be accessed at runtime. `@moduledoc` and `@doc` are examples of such attributes.

## Task

Define a function `Circle.area(r)` that computes the area of a circle. Define pi (3.14) as a module constant.