#!/bin/bash
## Sorts .m4 input and remove duplicates so that every row is unique.	
## Input: .m4
## Output: .m4

## Rearrange fields so that identifying fields are unique.
awk '{if ($1<$2) print $1"	"$2"	"$3"	"$4"	"$5"	"$6"	"$7"	"$8"	"$9"	"$10"	"$11"	"$12; else print $2"	"$1"	"$3"	"$4"	"$5"	"$10"	"$11"	"$12"	"$9"	"$6"	"$7"	"$8}' $1 |
sort -u # Sort rows and make every row unique
