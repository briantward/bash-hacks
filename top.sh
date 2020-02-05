#!/bin/bash
# record memory growth over time in firefox
while (true); do
    date >> top-out.txt;
    top -b -n1 | grep firefox | head -1 | awk '{print $6}' | cat >> top-out.txt;
    sleep 3
done
