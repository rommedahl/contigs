#!/bin/bash
# Remove overlaps when one contig is completely covered by the other contig.
# removeSubOverlapsM4.sh input.m4 > output.m4
awk '{if (($6 == 0 && $7 == $8) || ($10 == 0 && $11 == $12)); else print $0}' $1
