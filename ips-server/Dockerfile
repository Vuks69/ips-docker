# syntax=docker/dockerfile:1

FROM alpine:latest

RUN apk update && \
    apk add \
        iperf3 \
        iproute2-tc

COPY server.sh /

ENTRYPOINT [ "/bin/sh", "-c", "/server.sh" ]
