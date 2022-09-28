# Assignment

## Task

Define a private function `Math.factorial(n)` that computes
`n` factorial, also written "`n`"!. This is defined as follows:

* 0! equals 1
* k! equals k &times; (k-1)!

For example, 5! is equal to 1 &times; 2 &times; 3 &times; 4 &times; 5 = 120.

Next, define a public function `Math.binomial(n, k)` that computes
n! / (k! &times; (n-k)!).

Note the following:

* Factorials can grow large very quickly. This is no issue for Elixir:
  contrary to Java, C# or C++, integers are not limited in size. They'll consume
  the bits necessary to faithfully represent the number.
* Do not use the `/` operator for division: it always produces floating point numbers and the tests expect integers.
  Look up how to perform integer division.
