#!/bin/sh

graphs="rndrd-iops rndwr-iops rndrd-mbps rndwr-mbps"

for graph in $graphs; do
	gnuplot -p -e 'set terminal x11' ${graph}.plt
	#gnuplot -p -e 'set terminal jpeg; set output "'${graph}'.jpg"' ${graph}.plt
done
