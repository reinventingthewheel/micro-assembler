# The Micro Assembly Specification #

This is a specification of a very limited assembly language (almost machine code)
for the first level of abstraction from brainfuck.

It doest not provide several common operations (such as multiplier), and also lacks
syntax sugar such as comments, free whitespaces and macros.

Hence, every instruction should be written in the form:

    <I><A><N>

Where `<I>` is the instruction letter, `<A>` is the addressing mode symbol (whether
`#` or `$`), and `<N>` is a non-negative integer.

## Instruction Set ##

Here is the twelve instructions. Actually there are six, but each with two adressing
mode, `#` (immediate) and `$` (relative):


* `G #<N>`    -> Gets value from register to `<N>` memory address
* `G $<N>`    -> Gets value from register to memory address pointed by `<N>`
* `S #<N>`    -> Sets register value to `<N>`
* `S $<N>`    -> Sets register to value pointed by `<N>`
* `+ #<N>`    -> Adds `<N>` to register
* `+ $<N>`    -> Adds value pointed by `<N>` to register
* `- #<N>`    -> Subtracts `<N>` from register (storing result in register)
* `- $<N>`    -> Subtracts value pointed by `<N>` from register
* `J #<N>`    -> Jumps to line number `<N>`
* `J $<N>`    -> Jumps to line number pointed by `<N>`
* `C #<N>`    -> Skips next line if `<N>` is equals to register
* `C $<N>`    -> Skips next line if value pointed by `<N>` is equal to register
