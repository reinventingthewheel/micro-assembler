#! /bin/make

masm.bf: src/program-dumper.bf src/execution-loop.bf tools/mkdumper.py
	python tools/obfuscate.py < src/program-dumper.bf > masm.bf
	python tools/mkdumper.py < src/execution-loop.bf >> masm.bf

%.bf: masm.bf %.masm
	bf masm.bf < $*.masm > $*.bf

