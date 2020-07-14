# Installation

Just ensure you have a recent Elixir >= 1.10 and Erlang/OTP 23+.

# Usage

## Main

From the project home:
```
mix escript.build
```
then either
```
./exploring_mars [input_file]
# or
cat input_file | ./exploring_mars
# or
./exploring_mars < input_file
```
As the examples above show, if input file name argument is not provided,
input is read from stdin.

## Tests

To run tests:
```
mix test
```

Open `./coverage/index.html` for coverage info.

# Assumptions

If any of the lines contain syntax errors, the execution is aborted.

If plateau boundary is exceeded, the current probe is skipped, but program
execution continues.

# Initial Impression

The problem seems to me similar to an interpreter of a subset of
[Logo programming language](https://simple.wikipedia.org/wiki/Logo_(programming_language)).

# Extra features

Features not explicitly demanded in the enunciate.

Implemented:
* Boundary checks (a probe cannot move outside the plateau)
* Syntax error handling

Not implemented:
* Collision detection

I decided not to do collision detection, which would necessarily involve
reading the whole input before outputing anything, as it was not an explicit
requirement and I believe there is enough material already for an initial
assessment. I would be more than happy to implement the feature during the pair
programming session, though.
