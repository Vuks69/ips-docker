#!/bin/bash
set -e

for j in $@; do
	filename=$(basename "$j" .json)

	case "$filename" in
		"50010") export DELAY=0 ;;
		"50100") export DELAY=30 ;;
		"50210") export DELAY=50 ;;
		"50220") export DELAY=10 ;;
		"*") export DELAY=0 ;;
	esac

	times_raw=$(jq '.intervals[].sum.start' <"$j")
	times=
	# times=`seq -s' ' 1 $DELAY | xargs printf -- '.%.0s '`
	for ti in $times_raw; do
		times="$times $(bc <<<"$ti+${DELAY:-0}")"
	done
	# times="$times `seq -s' ' 1 $((100-$DELAY)) | xargs printf -- '.%.0s '`"
	values=($(jq '.intervals[].sum.bits_per_second' <"$j"))

	times=($times)
	paste <(printf "%s\n" "${times[@]}") <(printf "%s\n" "${values[@]}") >data/${filename}
done

gnuplot plot.plt >plot.xml
#firefox plot.xml
