#!/bin/bash
# Remove overlaps when one contig is in a list.
#
# Input:  Standard input with file or stream of .m4 format. List of contigs.
#
# remoteContigsM4.sh CONTIGLIST M4FILE
#
join -1 1 -2 2 -t '	' <(sort $1) <( sort -k2 <(join -1 1 -2 2 -t '	' <(sort $1) <(sort -k2 $2)))

