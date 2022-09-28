# Tutorial

Elixir, as a pure functional language, does not have looping constructs. Instead, loops can be implemented using a combination of recursion, pattern matching and multiclause functions.

As an example, let us take a look at the function `repeat(n, x)` that creates a list containing `n` occurrences of `x`.

```elixir
def repeat(0, x), do: []
def repeat(n, x), do: [x | repeat(n - 1, x)]
```

Make sure you take the time necessary to fully understand how this algorithm works.

* The base case is where `n == 0` is simple: 0 repetitions of anything is simple the empty list.
* Next comes the inductive case. In general, writing this case consists
  of finding a way to express `repeat(n, x)` in terms of `repeat(n - 1, x)`.
  In this example, the repetition of `n`&times;`x` is the equal
  to taking `(n-1)` &times; `x`, and adding an extra `x` to it.
