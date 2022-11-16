set term svg size 900,900 font "Helvetica Neue,18" rounded dashed

set title "Comparison of speeds"
set style data lines
set boxwidth 0.9
# set xtic rotate by -45 scale 0 font ",8"
set key top left
set yrange [0:*]
set xrange [0:60]

# Convert bits to megabits
set format y '%.0s %cbit'

FILES = system("find data/ -mindepth 1 | sort")
# TITLES = system("ls -1 data/ | sed 's/iperf3-50//g' | sort")
TITLES = "1:10::rate=20mbit,ceil=90mbit,prio=3 1:100::rate=5mbit,ceil=10mbit,prio=7 2:210::rate=5mbit,ceil=30mbit,prio=1 2:220::rate=40mbit,ceil=100mbit,prio=2"

plot for [i=1:words(FILES)] word(FILES,i) title word(TITLES,i)