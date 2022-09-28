# Assignment

## Basic Pattern Matching

Recall the following expression:

```elixir
a = 1
```

This is the most simple example of the *match* operator in Elixir. The match operator is much more powerful than the assignment operator in languages like Java or C#.

We can match, for example, a tuple to a simple variable:

```elixir
card = {2, :spades}
```

But we can also match the individual elements of the tuple to seperate variables (this is called destructuring):

```elixir
{value, suit} = {2, :spades}
```

You can even leverage pattern matching in function arguments:

```elixir
def doSomethingWithCard( { value, suit } ) do
    ...
end
```

## Ignoring Parameters

Say your function receives a tuple but is not interested in all its values:

```elixir
# Elixir
def caresOnlyAboutValue( { value, suit } ) do
    # Ignores suit
end
```

Elixir will think you made a mistake: you took the trouble
of declaring a variable `suit` but failed to use it!

In order to ignore a value, you need to do so explicitly:

```elixir
# Elixir
def caresOnlyAboutValue( { value, _ } ) do
    ...
end
```

The `_` means "I know there's something here, but I don't care what it is."

## Task

Write a function `Cards.same_suit?(card1, card2)` that checks whether
the cards have the same suit. Do *not* rely on `==` or `!=`;
instead, make solely use of pattern matching.
(This is solely for educational purposes;
in practice, there's nothing wrong with relying on equality.)