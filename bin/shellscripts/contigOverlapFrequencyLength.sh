#!/bin/bash
## Input:  ContigData (output from catContigsM4.sh), must be sorted.
## Output: Contig Id, Overlap frequency, Length
cut -f1,7 $1 | uniq -c | sort -nr | awk '{print $2"	"$1"	"$3}'

