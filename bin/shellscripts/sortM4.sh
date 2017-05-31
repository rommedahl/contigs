#!/bin/bash
## File to sort the .m4 file and remove duplicates so that every row contains unique information.	
## Input: .m4 file
## Output: .m4 file

p=6	## Set number of processes for sort
## Rearrange fields so that identifying fields are unique.
awk '{if ($1<$2) print $1"	"$2"	"$3"	"$4"	"$5"	"$6"	"$7"	"$8"	"$9"	"$10"	"$11"	"$12; else print $2"	"$1"	"$3"	"$4"	"$5"	"$10"	"$11"	"$12"	"$9"	"$6"	"$7"	"$8}' $1 |
sort -S1M --parallel=$p -u # Sort rows and make every row unique
