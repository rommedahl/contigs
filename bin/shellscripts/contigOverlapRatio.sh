#!/bin/bash
## Input:  ContigData (output from catContigsM4.sh), must be sorted.
## Output: Contig Id, Overlap ratio (sum of overlap lengths divided by contig length)

# http://www.unix.com/shell-programming-and-scripting/51129-column-sum-group-uniq-records.html

awk '{print $1"	"($6-$5)/$7}' $1 | awk '{arr[$1]+=$2} END {for (i in arr) {print i,arr[i]}}' | sort -k2 -nr
