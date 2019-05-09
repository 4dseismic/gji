#!/bin/bash

n=`basename $0 .sh`
#o=$n.eps
t=`echo $n | tr '_' ' ' `
v=gplot.vel

cat <<EOF > gplot.vel
 0.00 3.53
 1.00 4.47
 2.00 5.16
 3.00 5.60
 4.00 5.96
 6.00 6.50
 9.00 6.73
20.00 7.20
32.00 7.40
90.00 8.00
0 0
EOF

cat <<EOF > gplot.input
#set terminal svg size 1400,500 font ",24"
#set terminal latex size 1400,500 font ",24"
set terminal pdf size 17cm,4cm
set output "tp.pdf"
set grid
set yrange[10:0]
set xrange [0:50]
set size ratio -1
#set title "$t"
set xlabel "velocity (km/s) - distance (km)"
set ylabel "depth (km)"
set y2tics  0.25
set xtics 5
set y2label "reduced travel time (s)"
set link y2 via y/8.0 inverse y*8.0
set font ",20"
unset key
plot \\
EOF
l="with lines"

rm -f rays
i="1.55"
while [ $i != "7.05" ] 
do
f=depth_${i}_km
rayplot -P $v -d 0.05 -b $i -n 170 -r j.ray
cat j.ray >> rays
echo >> gplot.rays
i=`echo $i + 0.1 | bc`
done

echo "\"rays\" $l, \\" >> gplot.input

awk ' {  print $2,$1 } ' dump.vel > velocity
#cp dump.vel velocity

travelt -f $v -r 170 0.05 -d 0.0 -n 1300 -v 6.5 -b $i   -o jj
echo \"jj\"  axes x1y2 $l , \\ >> gplot.input
echo   \"sil.vel\"  $l >> gplot.input
gnuplot < gplot.input

