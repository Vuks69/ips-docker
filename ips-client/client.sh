#!/bin/sh
set -xe

sleep ${INITIAL_WAIT:-0}

echo "" > "/results/client/${PORT}.json"

iperf3 --client ips-server \
    --port $PORT \
    --reverse \
    --time ${TIME:-60} \
    --json \
    --udp \
    --bitrate 100M \
    --logfile "/results/client/${PORT}.json"
