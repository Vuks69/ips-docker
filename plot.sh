#!/bin/bash

for j in $1/*.json
do
	filename=$(basename "$j" .json)
	if jq -e '.error' < $j >&2 /dev/null
	then
		# echo $(readlink -f $j) has an error, skipping >&2
		# cat $j >&2
		continue
	fi
    times=$(jq '.intervals[].sum.start' < "$j")
	values=$(jq '.intervals[].sum.bits_per_second' < "$j")
    paste <( echo "${times[*]}" ) <( echo "${values[*]}" ) > data/${filename}
done

gnuplot plot.plt > plot.xml
firefox plot.xml