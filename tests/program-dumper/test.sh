#!/usr/bin/env bash
file=`basename $1 .test.masm`
bf ../../src/program-dumper.bf < "$file.test.masm" > /tmp/result.bf; diff "$file.expected.bf" /tmp/result.bf