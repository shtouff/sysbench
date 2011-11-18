#!/bin/sh

name=${1:-unknown}

modes="rndrd rndwr"
threads="1 2 4 8 16 32 64"
size=50

for mode in $modes; do
  for t in $threads; do 
    events=$(grep total\ number\ of\ events results/size\=${size}-threads\=${t}-mode\=${mode}.txt| awk '{ print $5 }')
    iops=$(echo "scale=2; ${events} / 600" | bc)


    mbps=$(grep -E '\(.*Mb/sec\)' results/size\=${size}-threads\=${t}-mode\=${mode}.txt| sed -r 's/^.*\(([0-9\.]+)Mb\/sec\).*$/\1/')


    echo ${t} ${iops} ${mbps}
  done 2>/dev/null | tee results/${mode}_${name}.dat
done
