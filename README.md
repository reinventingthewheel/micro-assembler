# The Micro Assembly Specification #

This is a specification of a very limited assembly language (almost machine code)
for the first level of abstraction from brainfuck.

It doest not provide several common operations (such as multiplier), and also lacks
labels and macros.

Hence, every instruction should be written in the form:

    <I> <A><N>

Where `<I>` is the instruction letter, `<A>` is the optional addressing mode symbol
and `<N>` is a non-negative integer.

The addressing mode symbol can be:

* `` (none)  -> Indicates an immediate value. The value will be exactly `<N>`
* `@`        -> Indicates that value is at `<N>` memory address
* `*`        -> Indicates a pointer. It will fetch operand value from the address stored at `<N>`

## Instruction Set ##

Some instructions only accepts imediate values, while others can work with values
stored on memory and pointers. Here are the instructions in all available forms:

* `L <N>`     -> **L**oads the value `<N>` into register
* `L @<N>`    -> **L**oads to register the value at `<N>` memory address
* `L *<N>`    -> **L**oads to register the value value pointed by `<N>`
* `D @<N>`    -> **D**umps register value into `<N>` memory address
* `D *<N>`    -> **D**umps register value into memory address pointed by `<N>`
* `+ <N>`     -> **Add**s `<N>` to register
* `+ @<N>`    -> **Add**s value at `<N>` memory address to register
* `+ *<N>`    -> **Add**s value pointed by `<N>` to register
* `- <N>`     -> **Subtract**s `<N>` from register (storing result in register)
* `- @<N>`    -> **Subtract**s value at `<N>` memory address from register
* `- *<N>`    -> **Subtract**s value pointed by `<N>` from register
* `J <N>`     -> **J**umps to line number `<N>`
* `J @<N>`    -> **J**umps to line number in `<N>` memory address
* `J *<N>`    -> **J**umps to line number pointed by `<N>`
* `= <N>`     -> Skips next line if register is **equals to** `<N>`
* `= @<N>`    -> Skips next line if register is **equals to** value at `<N>` memory address
* `= *<N>`    -> Skips next line if register is **equals to** value pointed by `<N>`
* `< <N>`     -> Skips next line if register is **less than** `<N>`
* `< @<N>`    -> Skips next line if register is **less than** value at `<N>` memory address
* `< *<N>`    -> Skips next line if register is **less than** value pointed by `<N>`
* `> <N>`     -> Skips next line if register is **greater than** `<N>`
* `> @<N>`    -> Skips next line if register is **greater than** value at `<N>` memory address
* `> *<N>`    -> Skips next line if register is **greater than** value pointed by `<N>`
* `R`         -> **R**eads a char from stdin to register
* `W`         -> **W**rites a char from register to stdout

Comments starts on the `;` character and ends at end of line. Whitespaces are free

