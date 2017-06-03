#!/bin/bash
# Prints ID of contigs in .m4 that completely covers the other contig.  
# superContigsM4.sh input.m4 > contigList
awk '{if ($6 == 0 && $7 == $8) print $2; else if ($10 == 0 && $11 == $12) print $1;}' $1

