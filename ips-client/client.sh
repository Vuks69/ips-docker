#!/bin/sh
set -xe

iperf3 --client ips-server --port "$PORT" --reverse --parallel 5 --time 60 "$UDP" --logfile /results/client/iperf3-${1}.log
