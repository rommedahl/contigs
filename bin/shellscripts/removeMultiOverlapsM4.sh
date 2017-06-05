#!/bin/bash
# Remove multiple overlaps with the same pair of contigs from sorted .m4 input.
# removeMultiOverlapsM4.sh input.m4 > output.m4
rev $1 | uniq -u -f 10 | rev
