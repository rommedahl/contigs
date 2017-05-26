#!/bin/bash

# Execure with ./contigs.sh 

echo 'Data analysis'

echo 'Display head'

#echo 'ID1	ID2	Similarity	Frac.Identical	Unused C1Start	C1End	C1Length	Reverse	C2Start	C2End	C2Length'

head data/data

echo 'Display head, relative info'

head data/data | awk '{print $6" "$7" "$8" "$10" "$11" "$12" = "$7-$6-($11-$10)}'

echo 'Display missmatch in length'

#cat data/data | awk '{if (($7-$6-($11-$10)) != 0) print ($7-$6-($11-$10))}' | wc -l

echo 'Counting lines/overlaps'

start=`date +%s`
#wc -l data/data
end=`date +%s`
runtime=$((end-start))
echo $runtime

echo 'Counting unique identifiers'

if [ ! -f data/IDsC1 ]; then
	echo 'IDsC1 does not exist.'
	cat data/data | awk '{print $1}' | uniq | sort --parallel=6 | uniq > data/IDsC1
fi
wc -l data/IDsC1

if [ ! -f data/IDsC2 ]; then
	echo 'IDsC2 does not exist.'
	cat data/data | awk '{print $2}' | uniq | sort --parallel=6 | uniq > data/IDsC2
fi
wc -l data/IDsC2

if [ ! -f data/IDs ]; then
	echo 'IDs does not exist.'
	cat data/IDsC1 data/IDsC2 | sort --parallel=6 | uniq > data/IDs
fi
wc -l data/IDs

echo 'Counting sub set contigs'

#cat data/data | awk '{if (($6 == 0 && $7 == $8) || ($10 == 0 && $11 == $12)) print $0}' | wc -l

echo 'Display auto contigs, same seq.'

cat data/data | awk '{if ($1==$2) print $0}' | wc -l
