#! /bin/make

masm.bf: src/program-dumper.bf src/execution-loop.bf tools/mkdumper.py
	cp src/program-dumper.bf masm.bf
	python tools/mkdumper.py < src/execution-loop.bf >> masm.bf

%.masm: masm.bf
	bf masm.bf < $*.masm > $*.bf

