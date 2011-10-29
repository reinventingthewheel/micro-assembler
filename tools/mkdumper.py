#! /usr/bin/python

"""
This Program takes a brainfuck program as input and writes another (different)
brainfuck program as output.
The output program, when executed, yields the first program. Hence, the output
program is a so called "dumper" of the input.

For instance if the output is identical to the input, then this program can be
called a "Quine".

The strategy to write out the dumper is the following:

First it creates a table (in the first eight memory slots) of the character
codes of the brainfuck instruction set (< > + - [ ] . ,), then, for each
instruction of the input program to be dumped, it moves the memory pointer to
the correct instruction in table (by using < or >), finnaly it prints out the
already set value ( . ).
"""

if __name__ == "__main__":

    import sys

    # Read the input brainfuck code
    code = sys.stdin.read()

    instructions = '<>+-[].,';

    # instruction to set to zero
    zero = '[-]';

    # print the constructor of the brainfuck instruction set table
    sys.stdout.write( zero + ('+' * ord('<')) + '>');
    sys.stdout.write( zero + ('+' * ord('>')) + '>');
    sys.stdout.write( zero + ('+' * ord('+')) + '>');
    sys.stdout.write( zero + ('+' * ord('-')) + '>');
    sys.stdout.write( zero + ('+' * ord('[')) + '>');
    sys.stdout.write( zero + ('+' * ord(']')) + '>');
    sys.stdout.write( zero + ('+' * ord('.')) + '>');
    sys.stdout.write( zero + ('+' * ord(',')));

    # keep track of where it's pointing at
    pos = 7

    # For each char in input code
    for c in code:

        # find the position in the brainfuck instruction set (if exists)
        i = instructions.find(c)

        # if it's actually a brainfuck instruction (i.e. not a comment)
        if i != -1:
            # calculate the relative motion to arrive at the desired table
            # position
            moves = i - pos

            # print out the corresponding < or > (or none if repeating last
            # instruction)
            sys.stdout.write( ('>' if moves > 0 else '<') * abs(moves) + '.')

            # update position in table
            pos = i

