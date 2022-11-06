#!/bin/sh
set -xe

iperf3 --client ips-server --port "$1" --reverse --parallel 5 --time 60 "$2" --logfile /results/client/iperf3-${1}.log
