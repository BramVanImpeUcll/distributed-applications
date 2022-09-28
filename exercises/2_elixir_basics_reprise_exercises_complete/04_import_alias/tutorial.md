# Tutorial

To call a function from a different module you use the module name in combination with the function name:

```elixir
defmodule Temperature do
  def kelvin_to_celsius(t) do
    t - 273.15
  end
end

defmodule Weather do
    def degrees_today_in_celsius() do
        Temperature.kelvin_to_celsius(fetch_degrees_kelvin())
    end

    def fetch_degrees_kelvin() do
        ...
    end

end
```

## Import

Calling functions from another module can be shortened by importing a module:

```elixir
defmodule Weather do
    import Temperature

    def degrees_today_in_celsius() do
        kelvin_to_celsius(fetch_degrees_kelvin())
    end

    ...
end
```

## Alias

You can even give a module a different name in the using module:


```elixir
defmodule Weather do
    alias Temperature, as: T

    def degrees_today_in_celsius() do
        T.kelvin_to_celsius(fetch_degrees_kelvin())
    end

    ...
end
```

The same holds true for an individual function:


```elixir
defmodule Weather do
    alias Temperature.kelvin_to_celsius, as: convert

    def degrees_today_in_celsius() do
        convert(fetch_degrees_kelvin())
    end

    ...
end
```