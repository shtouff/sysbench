#!/bin/bash

# (C) remi paulmier <remi.paulmier@gmail.com>. 
# this content is brought to you AS IS, under BSD License.

# inspired by Vadim Tkachenko's work on ssdperformanceblog.com

set -e

curd=`pwd`

modes="rndrd rndwr"
sizes=50
numsthreads="1 2 4 8 16 32 64 128 256 512"
maxtime=120
blocksize=16384

mkdir -p $curd/data $curd/results

for size in $sizes; do

	# prepare
	echo "### sysbench: PREPARE DATA ###"
	cd $curd/data
	sysbench --test=fileio --file-num=64 --file-total-size=${size}G prepare >/dev/null
	
	for mode in $modes; do
		
		echo "### sysbench: entering mode $mode ###"
        
		for numthreads in $numsthreads; do
			sync
			echo 3 > /proc/sys/vm/drop_caches
			
		    # run
			echo "### sysbench: $mode PASS with $numthreads threads ###" 
			sysbench --test=fileio \
				--file-total-size=${size}G \
				--file-test-mode=$mode \
				--max-time=$maxtime \
				--max-requests=0 \
				--num-threads=$numthreads \
				--file-num=64 \
				--file-io-mode=async \
				--file-fsync-freq=0 \
				--file-block-size=${blocksize} \
				run > $curd/results/size=${size}-threads=${numthreads}-mode=${mode}.txt
		done
	done
done

cd $curd
./get-plots.sh