# Assignment

Create a new application called `exercise`.

The goal of this exercise is to understand how mix works.

## Task 1

Create a module called `Exercise.Sage`. When you execute the `Exercise.Sage.say_wise_thing/0` function, it'll return the string "All life must be respected!".

Test this in your iex shell!

```text
iex> Exercise.Sage.say_wise_thing
"All life must be respected!"
```

## Task 2

Create a test that tests whether the function works.

## Task 3

Let your sage read your secret that you defined in a config. Do not hard code this!

```text
iex> Exercise.Sage.spill_secret()
:secret_defined_in_config
```

See if your change works by running the tests.

## Task 4

How can you start your application and execute code defined in the module in it?

(Hint: see the --sup flag when running mix new)

(Hint 2: see [this stack overflow post](https://stackoverflow.com/questions/30687781/how-to-run-an-elixir-application) for more pointers)