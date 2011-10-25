#! /bin/make

tmp:
	@touch /tmp/tmpmasm.bf

%.masm: tmp
	@cat $*.masm | bf masm.bf > /tmp/tmpmasm.bf
	@cat executor.bf >> /tmp/tmpmasm.bf
	@bf /tmp/tmpmasm.bf