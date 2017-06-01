#!/bin/bash
## Remove overlaps when one contig is in a list.
## Input: #1 List of contigs to remove #2 .m4
## Output: .m4
# remoteContigsM4.sh CONTIGLIST M4FILE
#
grep -vwf $1 $2

