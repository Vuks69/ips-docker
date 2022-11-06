# syntax=docker/dockerfile:1

FROM alpine:latest

RUN <<EOF
    apk update
    apk add iperf3
EOF

COPY client.sh /

ENTRYPOINT [ "/bin/sh", "-c", "/client.sh" ]
CMD [ "50001" ]
