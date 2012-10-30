#!/bin/bash

hostpath=$1
serie=$2

[ -d series/$serie ] || mkdir -p series/$serie
scp -p "root@${hostpath}/results/*.dat" series/$serie/
