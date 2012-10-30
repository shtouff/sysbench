#!/bin/bash

modes="rndrd rndwr"
threads="1 2 4 8 16 32 64 128 256 512"
size=50
duration=120

for mode in $modes; do
  for t in $threads; do 
    events=$(grep "total number of events" results/size\=${size}-threads\=${t}-mode\=${mode}.txt| awk '{ print $5 }')
    iops=$(echo "scale=2; ${events} / ${duration}" | bc)


	gbps=$(grep -E '\(.*Gb/sec\)' results/size\=${size}-threads\=${t}-mode\=${mode}.txt| sed -r 's/^.*\(([0-9\.]+)Gb\/sec\).*$/\1/')
	if [ x$gbps = x ]; then
		gbps=0
	fi
    mbps=$(grep -E '\(.*Mb/sec\)' results/size\=${size}-threads\=${t}-mode\=${mode}.txt| sed -r 's/^.*\(([0-9\.]+)Mb\/sec\).*$/\1/')
	if [ x$mbps = x ]; then
		mbps=0
	fi
	mbps=$(echo "scale=2; ${gbps} * 1024 + ${mbps}" | bc)

    echo ${t} ${iops} ${mbps}
  done > results/${mode}.dat 2>/dev/null
 done

echo "### plots generated ###"
