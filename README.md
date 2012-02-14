 The Micro Assembly Specification #

This is a specification of a very limited assembly language (almost machine code)
for the first level of abstraction from brainfuck.

It doest not provide several common operations (such as multiplier), and also lacks
labels and macros.

Hence, every instruction should be written in the form:

    <I> <A><N>

Where `<I>` is the instruction letter, `<A>` is the optional addressing mode symbol (`$`
can be used for relative access), and `<N>` is a non-negative integer.

## Instruction Set ##

Here are the 18 instructions. Actually there are 10, but 8 of them with two adressing
mode, immediate (no addressing symbol) and `$` (relative):


* `G <N>`     -> **G**ets value from register to `<N>` memory address
* `G $<N>`    -> **G**ets value from register to memory address pointed by `<N>`
* `S <N>`     -> **S**ets register value to `<N>`
* `S $<N>`    -> **S**ets register to value pointed by `<N>`
* `+ <N>`     -> **Add**s `<N>` to register
* `+ $<N>`    -> **Add**s value pointed by `<N>` to register
* `- <N>`     -> **Subtract**s `<N>` from register (storing result in register)
* `- $<N>`    -> **Subtract**s value pointed by `<N>` from register
* `J <N>`     -> **J**umps to line number `<N>`
* `J $<N>`    -> **J**umps to line number pointed by `<N>`
* `= <N>`     -> Skips next line if register is **equals to** `<N>`
* `= $<N>`    -> Skips next line if register is **equals to** value pointed by `<N>`
* `< <N>`     -> Skips next line if register is **less than** `<N>`
* `< $<N>`    -> Skips next line if register is **less than** value pointed by `<N>`
* `> <N>`     -> Skips next line if register is **greater than** `<N>`
* `> $<N>`    -> Skips next line if register is **greater than** value pointed by `<N>`
* `R`         -> **R**eads a char from stdin to register
* `W`         -> **W**rites a char from register to stdout

Comments starts on the `;` character and ends at end of line. Whitespaces are free

