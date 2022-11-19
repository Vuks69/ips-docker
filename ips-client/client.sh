#!/bin/sh
set -xe

echo "" > "/results/client/iperf3-${PORT}.json"

sleep ${INITIAL_WAIT:-0}

iperf3 --client ips-server \
    --port $PORT \
    --reverse \
    --time ${TIME:-60} \
    --json \
    --udp \
    --bitrate 100M \
    --logfile "/results/client/iperf3-${PORT}.json"
