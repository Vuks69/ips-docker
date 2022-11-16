#!/bin/sh
set -xe

echo "" > "/results/client/iperf3-${PORT}.json"

iperf3 --client ips-server \
    --port "$PORT" \
    --reverse \
    --time 60 \
    --json \
    --udp \
    --bitrate 100M \
    --logfile "/results/client/iperf3-${PORT}.json"
