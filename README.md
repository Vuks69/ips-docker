# ips-docker

A simple repository for a practical presentation of `tc` and the `HTB` qdisc.

## How to run?

Clone the repo

```sh
docker compose build
docker compose up
chmod +x plot.sh
./plot.sh results/server/*
```

Output is a gnuplot graph in png format.

## Random links for my presentation

this repository

https://man7.org/linux/man-pages/man8/tc-u32.8.html

https://tldp.org/HOWTO/Traffic-Control-HOWTO/

https://man7.org/linux/man-pages/man8/tc-htb.8.html

http://luxik.cdi.cz/~devik/qos/htb/
