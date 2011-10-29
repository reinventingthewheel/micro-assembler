#! /usr/bin/python

if __name__ == "__main__":

    import sys

    # Read the input brainfuck code
    code = sys.stdin.read()

    instructions = '<>+-[].,';

    # For each char in input code
    for c in code:

        # if it's actually a brainfuck instruction (i.e. not a comment)
        if c in instructions:
            sys.stdout.write( c )

