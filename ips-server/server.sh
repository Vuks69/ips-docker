#!bin/sh
set -xe -o ignoreeof

# add qdisc
tc qdisc add dev eth0 root handle 1: htb default 30

# add root class
tc class add \
    dev eth0 \
    parent 1: \
    classid 1:1 \
    htb \
        rate 10mbps \
        ceil 1mbps

# add subclasses
tc class add dev eth0 parent 1:1 classid 1:10 htb rate 1mbps ceil 6mbps # for tcp
tc class add dev eth0 parent 1:1 classid 1:20 htb rate 2mbps ceil 3mbps # for udp
tc class add dev eth0 parent 1:1 classid 1:30 htb rate 100kbps ceil 1mbps # for anything else (look first command, 'default 30')

# add filters that put packets in subclasses
# cat /etc/protocols -> tcp = 6; udp = 17
tc filter add \
    dev eth0 parent 1:0 \
        protocol ip prio 1 \
            u32 match ip \
                protocol 6 0xff \
                    flowid 1:10

tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip protocol 17 0xff flowid 1:20

for PORT in ${PORTS}; do
    touch "/results/server/iperf3-${PORT}.log"
    iperf3 --server \
        --one-off \
        --port "${PORT}" \
        --daemon \
        --json \
        --logfile "/results/server/iperf3-${PORT}.log"
done

wait
