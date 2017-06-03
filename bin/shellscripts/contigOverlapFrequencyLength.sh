#!/bin/bash
# Summarises contig frequency and also returns contig length.
# contigOverlapFrequencyLength.sh contigData(sorted) > contigOverlapFrequency
cut -f1,7 $1 | uniq -c | awk 'BEGIN {OFS="\t"} {print $2,$1,$3}'

