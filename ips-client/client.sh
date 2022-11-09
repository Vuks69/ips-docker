#!/bin/sh
set -xe

echo "" > "/results/client/iperf3-${PORT}.json"

iperf3 --client ips-server \
    --port "$PORT" \
    --reverse \
    --parallel 5 \
    --time 60 \
    --json \
    "$UDP" \
    --logfile "/results/client/iperf3-${PORT}.json"
