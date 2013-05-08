#!/usr/bin/gnuplot
reset
set terminal png size 1900,1080
set output "/home/bsmith/bsmith_public/rain_plot.png"

set xdata time
set timefmt "%m-%d-%Y-%H"
set format x "%m-%d-%Y-%H"
set xlabel "Date Time"
set xtics mirror in autofreq rotate

set ylabel "Inches of Rain"
set yrange [0:8]

set title "Rain in Columbia"
set key reverse Left outside
set grid

set style data linespoints

plot "/home/bsmith/repos/rasppiprojects/pi_weather_station/rain.dat" using 1:2 title "Rain In"




