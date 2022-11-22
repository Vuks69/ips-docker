set term pngcairo size 1100,900 font "Helvetica Neue,18" rounded
set output "plot.png"

set style data lines
set boxwidth 0.9
set key top right

set yrange [0:*]
set xrange [0:100]

set title "Wykres prędkości połączeń w czasie\n(parent:class/rate/ceil/priority)\n1:200/70mbit/100mbit/n-a"
set xlabel 'Czas [s]'
set ylabel 'Prędkość połączenia'
# Convert bits to megabits
set format y '%.0s %cbit'

set grid xtics ytics
set xtics autofreq 10


FILES = system("find data/ -type f")
TITLES = "1:10/20mbit/90mbit/3 1:100/5mbit/10mbit/7 200:210/5mbit/30mbit/1 200:220/40mbit/100mbit/2"

plot for [i=1:words(FILES)] word(FILES,i) title word(TITLES,i)