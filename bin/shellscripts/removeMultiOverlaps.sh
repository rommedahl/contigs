#!/bin/bash
# Remove multiple overlaps with the same pair of contigs.
# Assumes the two first fields to be sorted.
#
# Input:  Standard input with file or stream of .m4 format.
# Output: Standard output
#
rev $1 | uniq -u -f 10 | rev
