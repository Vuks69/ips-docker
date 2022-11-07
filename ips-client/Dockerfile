# syntax=docker/dockerfile:1

FROM alpine:latest

RUN apk update && \
    apk add \
        iperf3

COPY client.sh /
RUN chmod +x /client.sh

ENTRYPOINT [ "/bin/sh", "-c", "/client.sh" ]
