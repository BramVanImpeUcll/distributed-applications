# Assignment

A higher-order function is simply a function that takes one or more functions as input or returns one or more functions (or both).

There is nothing special or new about them in terms of concepts.

## Task

Write a function `Grades.passed_percentage(grades)` that, given
a list of grades (integers between `0` and `20`) computes
the percentage of passing grade.

* You should rely on the count function in Elixir's standard library.
* A grade is considered passing if it is at least `10`.
* The result should be a value between `0` and `100`.
* The result should be rounded to the nearest integer value.