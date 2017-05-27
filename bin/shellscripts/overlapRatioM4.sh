#!/bin/bash
# From a M4 it returns a table with contig ID, its number of occurences and its length.
# Input:  stdin in M4 file format
# Output: stout
# https://stackoverflow.com/questions/44197556/concatenation-of-columns-from-the-same-stream
$1 tee >(cut -f1,8) >(cut -f2,12) >/dev/null
