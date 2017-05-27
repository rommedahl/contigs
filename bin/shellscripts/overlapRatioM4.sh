#!/bin/bash
# From a M4 it returns a table with contig ID, its number of occurences and its length.
# Input: colapsed M4 file
# Output: stout

# http://www.unix.com/shell-programming-and-scripting/51129-column-sum-group-uniq-records.html

catM4file.sh $1 | awk '{print $1"	"($6-$5)/$7}' | awk '{arr[$1]+=$2} END {for (i in arr) {print i,arr[i]}}' | sort -k2 -nr
