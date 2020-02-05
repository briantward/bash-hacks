#!/bin/bash

cat /proc/modules |
while read module rest
do
    if [[ $(od -A n /sys/module/$module/taint) != " 000012" ]] ; then
        echo $module
    fi
done
