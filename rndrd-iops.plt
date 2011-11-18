#set terminal jpeg
#set terminal x11

set title "sysbench random reads on 50GB, during 10min"
set xlabel "threads"
set ylabel "IOPS"
set xrange [1:64]
set logscale x;
set xtics 1,2,64
plot "rndrd_Vortex2.dat" using 1:2 title "OCZ Vortex 2" with linespoints, \
     "rndrd_RevodriveX2.dat" using 1:2 title "OCZ Revodrive X2" with linespoints, \
     "rndrd_HP_SAS_15k.dat" using 1:2 title "HP SAS 15K rpm" with linespoints     
