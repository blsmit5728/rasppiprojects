#!/usr/bin/gnuplot
reset
set terminal png size 1900,1080
set output "/home/bsmith/bsmith_public/ins_plots/DATE_REPL.png"

set xdata time
set timefmt "%H-%M"
set format x "%H-%M"
set xlabel "Date Time"
set xtics mirror in autofreq rotate

set ylabel "Temp in the House"
set yrange [30:90]

set title "Temp inside my House"
set key reverse Left outside
set grid

set style data linespoints

plot "/beaglebone/DATE_REPL" using 1:2 title "Temp F"




