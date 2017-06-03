#!/bin/bash
# Remove overlaps when one contig is covered by the other contig.
#
# Input:  Standard input with file or stream of .m4 format.
# Output: Standard output
#
awk '{if (($6 == 0 && $7 == $8) || ($10 == 0 && $11 == $12)); else print $0}' $1
