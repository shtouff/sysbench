#!/bin/bash

modes="rndrd rndwr"
series="$*"

function gengraph()
{
	local mode=$1
	local title=$2
	local ylabel=$3
	local column=$4

	plotfile=$(mktemp -q) || {
		echo could not create temp file, aborting
		exit 1
	}

	set -- $series
	cat <<EOF > $plotfile
set title "$title"
set xlabel "threads"
set ylabel "$ylabel"
#set xrange [1:64]
set logscale x;
set xtics 1,2,512
set key on under 
plot \\
EOF
	fflag=1
	while [ $# -gt 0 ]; do
	    # metadata
		name=$1
		desc=$1
		
		[ -f series/$1/metadata ] && . series/$1/metadata
		
		if [ $fflag -eq 0 ]; then
			echo -n ", " >> $plotfile
		else
			fflag=0
		fi
		echo -n '"'"series/$1/$mode.dat"'"'" using 1:$column title "'"'"$desc"'"'" with linespoints" >> $plotfile
		shift
	done
	gnuplot -p -e 'set terminal x11 size 800,600' $plotfile
    gnuplot -p -e 'set terminal jpeg size 800,600; set output "'graphs/${mode}-${column}'.jpg"' $plotfile

	rm $plotfile
}

gengraph rndrd "Sysbench reads IOPS (50 GB dataset, 2min per pass)" "IOPS" 2
gengraph rndrd "Sysbench reads MB/s (50 GB dataset, 2min per pass)" "MB/s" 3
gengraph rndwr "Sysbench writes IOPS (50 GB dataset, 2min per pass)" "IOPS" 2
gengraph rndwr "Sysbench writes MB/s (50 GB dataset, 2min per pass)" "MB/s" 3
