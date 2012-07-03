#!/usr/bin/env bash
file=`basename $1 .test.masm`
bf ../../src/program-dumper.bf < "$file.test.masm" > /tmp/result.bf; bash "$file.expected.sh" > /tmp/expected.bf; diff /tmp/expected.bf /tmp/result.bf