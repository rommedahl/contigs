#!/bin/bash
# Keep rows in .m4 input when both contigs in overlap are not in contig list.
# removeContigsM4.sh contigList input.m4 > output.m4
join -1 1 -2 2 -v2 -t '	' <(sort $1 -u) <( sort -k2 <(
	join -1 1 -2 2 -v2 -t '	' <(sort $1 -u) <(sort -k2 $2)
))
