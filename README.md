Some files (scripts, gnuplot, ...) to produce sysbench reports


Usage:


# first copy the needed objects on server1
./rsync -av host/ server:/where/to/bench/

# then log on server1 && run the bench (pretty long)
ssh server1
cd /where/to/bench
./gen-results.sh 

# then, on your client machine, get the results and create a new serie for
# them (serie 5 for example)
./get-results.sh server1:/where/to/bench 5

# finally, provided you computed 5 different series, you can gen a graph 
# comparing these 5 series:
./gen-graphs.sh 1:2:3:4:5