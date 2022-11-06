#!bin/sh
set -xe -o ignoreeof

for port in "$@"; do
    iperf3 --server --port "${port}" --daemon --json --logfile /results/server/iperf3-${port}.log
done