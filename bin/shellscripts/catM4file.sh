#!/bin/bash
# From a M4 it returns a table with contig ID, its number of occurences and its length.
# Input:  stdin in M4 file format
# Output: stout

# 8 fields
# Id(1,2), Sim.(3), Frac(4), Zero(5), O.Start(6,10), O.End(7,11), Length(8,12), Reverse(9)

{ awk '{print $1,$3,$4,$5,$6,$7,$8,$9}' $1; awk '{print $2,$3,$4,$5,$10,$11,$12,$9}' $1; }

# NOTE: Cut can not change the order of the fields
# { cut -f1,3,4,5,6,7,8,9 $1 } ; cut -f2,3,4,5,10,11,12,9 $1 ; }

