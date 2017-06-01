#!/bin/bash
## Concatenates contig data in .m4.
## Input: .m4
## Output: 8 fields. Id(1|2), Sim.(3), Frac(4), Zero(5), O.Start(6|10), O.End(7|11), Length(8|12), Reverse(9)

awk 'BEGIN {OFS="\t"} {print $1,$3,$4,$5,$6,$7,$8,$9"\n"$2,$3,$4,$5,$10,$11,$12,$9}' $1

