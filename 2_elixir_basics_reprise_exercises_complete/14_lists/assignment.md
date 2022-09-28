# Assignment

A list in Elixir is a dynamic, variable-sized collection of data:

```elixir
example_list = [1, 2, 3]
```

They look like simple arrays but are internally represented as a linked list. A linked list is a series of pairs (also called nodes). 

Background information on linked-lists as data structure can be found in [this presentation](./linked-lists.pdf).

Elixir's syntax for linked lists is as follows:

* The empty list is written `[]`.
* A node is written `[ item | next ]`.

Thus, the list containing the values `1`, `2`, `3` is written

```elixir
list = [ 1 | [ 2 | [ 3 | [] ] ] ]
```

This representation is equivalent to this one `[1, 2, 3]`. It is easier to write down lists with comma seperated values but it is very important to remember that the actual storage in memory is as written above.

You can even combine both notations. The following notations all denote the same list:

* `[1 | [2, 3, 4]]`
* `[1, 2 | [3, 4]]`
* `[1, 2, 3 | [4]]`
* `[1, 2, 3, 4 | []]`

In other words, you can see the `|` as a form of concatenation:
the items before it get joined with the list after the `|`.
In practice, you'll encounter the `[head | tail]` notation relatively often.
Make sure you understand its meaning:

* The list's first item is `head`.
* All other items are grouped in a smaller list named `tail`.

In the case of `[1, 2, 3, 4]`,
`head` equals `1` and `tail` equals `[2, 3, 4]`.


Knowing that lists are internally represented by a linked-list is important:

* Only by knowing how linked list operate internally will you be able
  to make educated guesses regarding the performance of your algorithms.
  If you work with linked lists as if they are arrays, you'll probably
  end up with very inefficient code.
* To operate on linked lists, you often need to descend
  to a lower abstraction level, i.e., writing algorithms
  for linked lists involves working with the chain structure.

## Task

Write a function `Util.range(a, b)` that returns the list `[a, a+1, ..., b]`.