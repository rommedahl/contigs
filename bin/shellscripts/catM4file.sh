#!/bin/bash
# From a M4 it returns a table with contig ID, its number of occurences and its length.
# Input:  stdin in M4 file format
# Output: stout
{ cut -f1,3,4,5,6,7,8,9 $1; cut -f2,3,4,5,10,11,12,9 $1; }
