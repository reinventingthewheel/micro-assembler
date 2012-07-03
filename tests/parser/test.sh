#!/usr/bin/env bash
filename=`basename $1 .test.masm`
dir=`dirname $1`
file="$dir/$filename"
bf "$dir/../../src/parser.bf" < "$file.test.masm" > /tmp/result.bf; bash "$file.expected.sh" > /tmp/expected.bf; diff /tmp/expected.bf /tmp/result.bf