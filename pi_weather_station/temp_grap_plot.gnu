#!/usr/bin/gnuplot
reset
set terminal png size 1900,1080
set output "/home/bsmith/bsmith_public/deg_plot.png"

set xdata time
set timefmt "%m-%d-%Y-%H"
set format x "%m-%d-%Y-%H"
set xlabel "Date Time"
set xtics mirror in autofreq rotate

set ylabel "Degrees F"
set yrange [-10:100]

set title "Temperature in Columbia"
set key reverse Left outside
set grid

set style data linespoints

plot "/home/bsmith/repos/rasppiprojects/pi_weather_station/data.dat" using 1:2 title "Temp F", \
"" using 1:3 title "Wind speed",\
"" using 1:4 title "Dew Point"




