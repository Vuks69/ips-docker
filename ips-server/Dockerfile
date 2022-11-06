# syntax=docker/dockerfile:1

FROM alpine:latest

RUN apk update && \
    apk add \
        iperf3 \
        iproute2-tc

# /etc/protocols -> tcp = 6; udp = 17
RUN tc qdisc add dev eth0 root handle 1: htb default 30 && \
    tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbps ceil 1mbps && \
    tc class add dev eth0 parent 1:1 classid 1:10 htb rate 1mbps ceil 6mbps && \
    tc class add dev eth0 parent 1:1 classid 1:20 htb rate 2mbps ceil 3mbps && \
    tc class add dev eth0 parent 1:1 classid 1:30 htb rate 100kbps ceil 1mbps && \
    tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip protocol 6 0xff flowid 1:10 && \
    tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip protocol 17 0xff flowid 1:20

COPY server.sh /

ENTRYPOINT [ "/bin/sh", "-c", "/server.sh" ]
CMD [ "50001", "50002" ]