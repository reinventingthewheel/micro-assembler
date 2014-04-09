#! /bin/make

masm.bf: src/parser.bf src/execution-loop.bf tools/mkdumper.py
	python tools/obfuscate.py < src/parser.bf > masm.bf
	python tools/mkdumper.py < src/execution-loop.bf >> masm.bf

%.bf: masm.bf %.masm
	../brainfuck/bf masm.bf < $*.masm > $*.bf

