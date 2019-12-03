#!/bin/sh

kube-bench --version 1.16 > report.out
cat report.out
failures=$(cat report.out | grep '\[FAIL\]' | /usr/bin/wc -l )

if [ $failures != 0 ]; then
  exit 1
else
  exit 0
fi


