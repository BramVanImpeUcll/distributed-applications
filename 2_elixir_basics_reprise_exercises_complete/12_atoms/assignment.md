# Assignment

## Atoms

Atoms are, simply put, literal named constants. This is what an atom looks like: `:abc`, or `:hello`.

It looks a lot like a string, but instead of being
surrounded by double quotes, there's a colon in front.

An atom consists of two parts: the *text* (everything after the colon that you provide in the definition) and the *value*. At runtime, the text of an atom is stored in the *atom table*. Every reference to that atom is replaced with a value that is a reference to the atom table.

So when typing `var = :hello`, the variable `var` only contains a value that is a pointer to an entry in the atom table containing `hello`.

This means that atoms are a human-readable way of defining very low-footprint constants (thanks to the atom table being used internally).

## Example

As an example usage of atoms, let's implement the core functionality of rock-paper-scissors.
First we need to decide how to represent the three possible choices: rock, paper, and scissors.
We have many options:

* Strings: overkill. Too flexible and slow.
* Integers: too abstract. We'd have to remember which number represents which choice.
* Booleans: not enough of them.
* Atoms: aha! Idiomatic and simple. Perfect!

Now, let's write a function `beats?(x, y)` that checks whether `x` beats `y`.

| `x` | `y` | `x` beats `y` |
|:-:|:-:|:-:|
|rock|rock|`false`|
|rock|paper|`false`|
|rock|scissors|`true`|
|paper|rock|`true`|
|paper|paper|`false`|
|paper|scissors|`false`|
|scissors|rock|`false`|
|scissors|paper|`true`|
|scissors|scissors|`false`|

According to this table, there are 9 possible input combinations,
for 3 of which `beats?` should return `true`. We can implement this
by picking out these 3 specific cases and implementing all others
using a catch all clause.

```elixir
defmodule RockPaperScissors  do
  def beats?(:rock    , :scissors), do: true
  def beats?(:scissors, :paper   ), do: true
  def beats?(:paper   , :rock    ), do: true
  def beats?(x, y) when is_atom(x) and is_atom(y), do: false
end
```

When you stop to think about it this is actually quite weird. We can define the same function multiple times with different arguments (some of which are even hardcoded!) and Elixir will automatically call the right one at runtime. This sophisticated form of overloading is using a technique called *pattern-matching* which will be explored in-depth during next week's exercises.

## Task

Implement a function `Cards.higher?(x, y)` that checks whether `x` is a higher card than `y`.
There are thirteen possible cards. They are, in increasing order of value: `2`, ..., `10`, `:jack`, `:queen`, `:king`, `:ace`.

## Optional Reading Material

Atoms are internally used all over the place in Elixir. For example, code has to be stored in memory.
Say you define the following module:

```elixir
# Elixir
defmodule Foo do
  def bar() do
    ...
  end
end
```

This code first needs to be parsed and then evaluated. In other words,
Elixir needs some data structure representing this code.
This is generally called an Abstract Syntax Tree (or AST for short).
You can see what it looks like as follows:

```elixir
iex(1)> quote do
...(1)>   defmodule Foo do
...(1)>     def bar() do
...(1)>     end
...(1)>   end
...(1)> end
{:defmodule, [context: Elixir, import: Kernel],
 [
   {:__aliases__, [alias: false], [:Foo]},
   [
     do: {:def, [context: Elixir, import: Kernel],
      [{:bar, [context: Elixir], []}, [do: {:__block__, [], []}]]}
   ]
 ]}
```

The details of this structure are not important, but you can
discern a few familiar details in it: the `defmodule` appears as an atom,
and so do `Foo`, `def` and `bar`. In fact, all essential parts
of the code are present in this structure.

Admittedly, atoms are not really necessary to make this possible: Elixir
could just as well have used strings for this. So, why atoms?
Well, it's all about efficiency.

Let's have a quick thought experiment. It's not very true to reality,
but it will suffice for explanatory purposes. Imagine we're writing
our own Elixir interpreter and we need to decide what to
use to represent identifiers, keywords, etc.
Say we opt for strings.

We have a module of hundreds of functions and we choose to call one of them, e.g., `foo`.
Elixir would then have to go through the module, looking for a function
with that name. Given that identifiers are represented by regular strings,
this involves many string comparisons, which are relatively slow:
both strings' characters have to be compared one by one.

There are plenty of other scenarios where strings are slow:
for example, say that a function resides on a different
machine (this is a distributed applications course after all),
we'd have to copy the full name to that other machine.
If many calls need to be made, copying all these strings
will amount to considerable overhead.

Strings are nice if you actually need related operations on strings
such as slicing or converting to uppercase. But none
of these is useful when dealing with identifiers. In fact, very
few operations are necessary: we want to be able to efficiently
compare and copy identifiers. Strings are slow for both these operations.

Instead of using strings, which provide you with a a lot
of unnecessary flexibility, let's find another data type
that is more restricted yet more efficient. A good choice would
be a simple integer. Comparing them is a simple operation (e.g., no loops involved)
and copying them is very fast.

The real Elixir does just that: atoms are actually integers.
Internally, a large table associating atoms to integers is kept.
Whenever you mention an atom, Elixir
will look it up in this table to see if it has been
encountered before. If that is the case, the associated integer
is returned. If not, the atom is added to the table and
linked to an as of yet unused integer. This table is also
kept synchronized across machines, allowing
atoms to be used to communicate efficiently between machines.

If you're still confused about why atoms are useful:
we'll be making plenty use of them in the exercises.
When you get there, think about what impact efficiency-wise it
would have on your program if you'd use strings instead of atoms.
In fact, you've already made use of atoms without realizing it:
in Elixir, `true` and `false` are actually atoms. Imagine
what it would mean in C#/Java/... if you were to have `"true"` and
`"false"` instead of the built-in booleans.
