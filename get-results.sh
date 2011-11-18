#!/bin/sh

scp -p chazfw1:/media/ssd-test/sysbench/results/*.dat .
scp -p chazfw1:/media/sas-test/sysbench/results/*.dat .
scp -p dwh1:/var/lib/mysql/sysbench/results/*.dat .
