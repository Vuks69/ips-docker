#!bin/sh
set -xe

# add qdisc
tc qdisc add dev eth0 root handle 1: htb default 100

# add root class
tc class add \
    dev eth0 \
    parent 1: \
    classid 1:1 \
    htb \
        rate 100mbit \
        ceil 100mbit

# add subclasses
tc class add dev eth0 parent 1:1 classid 1:10 htb rate 20mbit ceil 90mbit prio 3
tc class add dev eth0 parent 1:1 classid 1:100 htb rate 5mbit ceil 10mbit prio 7 # for anything else (look first command, 'default 100')

tc class add dev eth0 parent 1:1 classid 1:200 htb rate 70mbit ceil 100mbit
tc class add dev eth0 parent 1:200 classid 1:210 htb rate 5mbit ceil 30mbit prio 1
tc class add dev eth0 parent 1:200 classid 1:220 htb rate 40mbit ceil 100mbit prio 2

# add filters that put packets in subclasses
# filtering is done by source port of server (aka iperf3 server's port)
tc filter add \
    dev eth0 \
    parent 1:0 \
    u32 match ip \
        sport 50010 0xffff \
            flowid 1:10

tc filter add dev eth0 parent 1:0 u32 match ip sport 50210 0xffff flowid 1:210
tc filter add dev eth0 parent 1:0 u32 match ip sport 50220 0xffff flowid 1:220


for PORT in $PORTS ; do
    echo "" > "/results/server/${PORT}.json"
    iperf3 --server \
        --one-off \
        --port $PORT \
        --json \
        --logfile "/results/server/${PORT}.json" &
    PIDS="$PIDS $!"
done

wait $PIDS
