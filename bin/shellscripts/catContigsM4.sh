#!/bin/bash
# Concatenates contig data from .m4 input.
# catContigsM4.sh input.m4 > contigData
awk 'BEGIN {OFS="\t"}
{print $1,$3,$4,$5,$6,$7,$8,$9"\n"$2,$3,$4,$5,$10,$11,$12,$9}' $1
