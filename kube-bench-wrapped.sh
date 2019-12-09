#!/bin/sh

kube-bench --version 1.16 > report.out
cat report.out
failures=$(cat report.out | grep '\[FAIL' | grep -v -E "$IGNORED_BENCHMARKS" | /usr/bin/wc -l )

exit $failures

