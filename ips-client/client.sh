#!/bin/sh
set -xe

touch "/results/client/iperf3-${PORT}.log"

iperf3 --client ips-server \
    --port "$PORT" \
    --reverse \
    --parallel 5 \
    --time 600 \
    "$UDP" \
    --logfile "/results/client/iperf3-${PORT}.log"
