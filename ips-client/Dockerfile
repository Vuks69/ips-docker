# syntax=docker/dockerfile:1

FROM alpine:latest AS build-client

RUN <<EOF
    apk update
    apk add iperf3
EOF
