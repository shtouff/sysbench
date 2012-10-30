#!/bin/bash

hostpath=$1

rsync -av host/ root@${hostpath}/
