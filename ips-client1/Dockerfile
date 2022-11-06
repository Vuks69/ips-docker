# syntax=docker/dockerfile:1

FROM alpine:latest

ARG ipaddr

RUN ip link set eth0 down \
    && ip addr flush dev eth0 \
    && ip addr add ${ipaddr}/24 dev eth0