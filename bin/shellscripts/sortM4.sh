#!/bin/bash
# Sort .m4 input and remove duplicates to make every row unique.	
# sortM4.sh input.m4 > output.m4
awk 'BEGIN {OFS="\t"} # Rearrange fields to make ID combinations unique
{if ($1<$2)
	print $0;
else
	print $2,$1,$3,$4,$5,$10,$11,$12,$9,$6,$7,$8}' $1 |
sort -u # Sort rows and make every row unique
