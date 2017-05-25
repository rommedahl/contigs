cat data/OrginalData.m4 | uniq | awk '{if (($6 == 0 && $7 == $8) || ($10 == 0 && $11 == $12)); else print $0}' |
awk '{if ($1<$2) print $1"	"$2"	"$3"	"$4"	"$5"	"$6"	"$7"	"$8"	"$9"	"$10"	"$11"	"$12; else print $2"	"$1"	"$3"	"$4"	"$5"	"$10"	"$11"	"$12"	"$9"	"$6"	"$7"	"$8}' |
sort | uniq > data/data.moas

# First awk identifies the contigs that are entirely contained in an other contig.

# Second awk identifies identical rows. 


