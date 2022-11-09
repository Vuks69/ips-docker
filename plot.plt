set term svg size 1000,800 font "Helvetica Neue,9" rounded dashed
set title "Comparison of speeds"
set style data lines
set boxwidth 0.9
# set xtic rotate by -45 scale 0 font ",8"
set key top left
set yrange [0:*]

# Convert bits to megabits
set format y '%.0s %cbit'

plot 'data/iperf3-50001', 'data/iperf3-50002'