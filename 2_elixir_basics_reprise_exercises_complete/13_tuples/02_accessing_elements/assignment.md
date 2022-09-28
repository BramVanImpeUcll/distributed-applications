# Assignment

Given a tuple, you'll probably want to access its elements.

This can be done in the following way:

```elixir
xs = { 1, 2, 3 }

size = tuple_size(xs)
first = elem(xs, 0)
second = elem(xs, 1)
third = elem(xs, 2)
```

## Task

Write a function `Cards.same_suit?(card1, card2)` that checks whether
the cards have the same suit.

A card is represented by a tuple as follows: `{value, suit}`
