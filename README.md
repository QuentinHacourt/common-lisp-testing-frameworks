# common-lisp-testing-frameworks

Just a simple codebase that I wrote as an example in order to try out a bunch of testing frameworks.

## Test Subject

The tests are ran on a small library that is meant to calculate entropy but also has a bunch of helper functions. Normally you wouldn't expose those helper functions but here it is done just to artificially increase the amount of code that can be tested. Some of the code has been written in a non idiomatic and slightly convoluded way, avoiding built in common lisp functions, again with the idea of having more code to run tests on.

## Tests

Tests have been written in three different frameworks.

- fiveam
- parachute
- lisp unit 2

The range of all tests is almost identical.
