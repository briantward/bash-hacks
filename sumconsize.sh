#!/bin/bash
# use this script to sum up the container size of all running containers reported in a sosreport
sum=0
for i in docker_inspect_*; do
  size=$(cat $i | jq .[0].VirtualSize)
  if [ $size != null ]; then
    echo $size
    sum=$(($sum + $size))
  fi
done
echo $sum bytes
echo $(($sum/1000)) kilobytes
echo $(($sum/1000000)) megabytes
echo $(($sum/1000000000)) gigabytes
