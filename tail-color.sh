#!/bin/bash

tail -100f $1 | awk '
/INFO/ {print "\033[32m" $0 "\033[39m"}
/WARNING/ {print "\033[33m" $0 "\033[39m"}
/Exception/ {print "\033[31m" $0 "\033[39m"}
/ERROR/ {print "\033[31m" $0 "\033[39m"}
/CRITICAL/ {print "\033[31m" $0 "\033[39m"}
'
