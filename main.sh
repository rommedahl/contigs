#!/bin/bash

## User input ##################################################################

## Enter path to .m4 input data
m4File=data/sample.n128.m4

## Sorting - Removes duplicate overlaps 1 = yes (recommended), 0 = no
m4sorting=0

## Max number of overlaps for each contig. 0 = no max number
contigMaxOverlapFrequency=0

## Max overlap ratio for each contig. 0 = no max overlap ratio
contigMaxOverlapRatio=0

## Keep overlaps when none of the contigs are completely overlapped by the other.
keepSuperContigs=0

## Only keep contigs that never are completely overlapped by another contig.
keepCondorcetSuperContigs=0

## Code ########################################################################

## Add path to script folders
PATH=$PATH:/bin:/bin/

m4Input="${m4File}"

## Sorting
if [ $m4sorting = 1 ]
then
	if [ ! -f "${m4Input}.sort" ]; then sortM4.sh "${m4Input}" > "${m4Input}.sort"; fi
	m4Input="${m4Input}.sort"
elif [ $m4sorting = 0 ]
then
	:
else
	echo "Setting for sorting not valid. Aborts"
	exit
fi


## Produce list of contigs to keep
contigs2keep="${m4Input}.contigs.2keep"
echo > "${contigs2keep}"

## Create file with contig data
contigInput="${m4Input}.contigs"
if [ $contigMaxOverlapFrequency = 1 ] || [ $contigMaxOverlapRatio = 1 ]
then
	if [ ! -f "${contigInput}" ]; then catContigsM4.sh "${m4Input}" | sort > "${contigInput}"; fi
fi

## Overlap frequencies to keep
if [ ! contigMaxOverlapFrequency = 0 ];
then
	contigOverlapFrequencyLength.sh "${contigInput}" > "${contigInput}.FrequencyLength"
	keepContigFrequenciesOrRatio.sh -l "${contigMaxOverlapFrequency}" -u 10000000 "${contigInput}.FrequencyLength" >> "${contigs2keep}"
fi

## Overlap ratios to keep
if [ ! contigMaxOverlapRatio = 0 ];
then
	contigOverlapRatio.sh "${contigInput}" > "${contigInput}.Ratio"
	keepContigFrequenciesOrRatio.sh -l "${contigMaxOverlapRatio}" -u 10000000 "${contigInput}.Ratio" >> "${contigs2keep}"
fi

if [ ! keepSuperContigs = 0 ] || [ ! keepCondorcetSuperContigs = 0 ];
then
	keepSuperContigsM4.sh "${m4Input}" > "${m4Input}.superContigs"
	m4Input="${m4Input}.superContigs"
fi


## (CondorcetS)Supercontigs to keep
## Reduce list by making a new list of contigs

exit

if [ ! keepCondorcetSuperContigs = 0 ];
then
	superContigInput="${m4Input}.superContigs"
	superContigsM4 "${m4Input}" > "${superContigInput}"
	contigOverlapRatio.sh "${contigInput}" > "${contigInput}.Ratio"
	keepContigFrequenciesOrRatio.sh -l "${contigMaxOverlapRatio}" -u 10000000 "${contigInput}.Ratio" >> "${contigs2keep}"
fi




