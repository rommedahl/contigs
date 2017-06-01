#!/bin/bash

## User input ##################################################################

## Enter path to .m4 input data
m4File=data/orginal

## Sorting - Removes duplicate overlaps.
##1 = yes (recommended), 0 = no
m4sorting=1

## Max number of overlaps for each contig. 0 = no max number
contigMaxOverlapFrequency=0

## Max overlap ratio for each contig. 0 = no max overlap ratio
contigMaxOverlapRatio=0

## Keep overlaps when none of the contigs are completely overlapped by the other.
## 1 = yes (recommended), 0 = no
keepSuperContigs=0

## Only keep contigs that never are completely overlapped by another contig.
keepCondorcetSuperContigs=1

## Code ########################################################################

echo "Script is running"
start=`date +%s`

PATH=$PATH:/bin:/bin/ ## Add path to script folders

m4Input="${m4File}"	## Sets the input pointer to be the data file.
m4InputBase="${m4File%.m4}"

## Start message.

## Sorting

if [ ! $m4sorting = 0 ]
then
	echo "Sorting .m4 file : $((`date +%s`-start)) s"
	if [ ! -f "${m4Input}.sort" ]; then sortM4.sh "${m4Input}" > "${m4InputBase}.sort.m4"; fi ## Sorts to new filename
	m4Input="${m4InputBase}.sort.m4" ## Sets the input pointer to the new file name
elif [ $m4sorting = 0 ]
then
	: ## Do nothing
else
	echo "Setting for sorting not valid. Abort."
	exit
fi

if [ ! $contigMaxOverlapFrequency = 0 ] || [ ! $contigMaxOverlapRatio = 0 ]
then
	echo "Create contig file : $((`date +%s`-start)) s"
	contigInput="${m4InputBase}.contigs" ## Create file name for contig data
	if [ ! -f "${contigInput}" ]; then catContigsM4.sh "${m4Input}" | sort > "${contigInput}"; fi ## Add data to that file
fi

if [ ! $contigMaxOverlapFrequency = 0 ] || [ ! $contigMaxOverlapRatio = 0 ] || [ ! $keepCondorcetSuperContigs = 0 ]
then
	contigs2keep="${m4InputBase}.contigs2keep" ## File name for list of contigs to keep
	contigs2remove="${m4InputBase}.contigs2remove" ## File name for list of contigs to remove
	echo > "${contigs2remove}" ## Empty file with that name
fi

## (CondorcetS)Subcontigs to remove sent to remove list
if [ ! $keepCondorcetSuperContigs = 0 ];
then
	echo "Appends subcontigs for removal : $((`date +%s`-start)) s"
	subContigsM4.sh "${m4Input}" >> "${contigs2remove}"
	CONDERCET=".cond"
fi

## Overlap frequencies to keep
if [ ! $contigMaxOverlapFrequency = 0 ];
then
	echo "Appends contigs above max overlap frequency for removal : $((`date +%s`-start)) s"
	contigOverlapFrequencyLength.sh "${contigInput}" > "${contigInput}.FrequencyLength" ## File with contig frequency and length
	removeContigFrequenciesOrRatio.sh -l 0 -u "${contigMaxOverlapFrequency}" "${contigInput}.FrequencyLength" >> "${contigs2remove}" ## Add contigs outside range to removelist
	FREQ=".freq"
fi

## Overlap ratios to keep
if [ ! $contigMaxOverlapRatio = 0 ];
then
	echo "Appends contigs above max overlap ratio for removal : $((`date +%s`-start)) s"
	contigOverlapRatio.sh "${contigInput}" > "${contigInput}.Ratio" ## File with contig overlap ratio
	removeContigFrequenciesOrRatio.sh -l 0 -u "${contigMaxOverlapRatio}" "${contigInput}.Ratio" >> "${contigs2remove}" ## Add contigs outside range to removelist
	RATIO=".ratio"
fi

## Keep only overlaps without sub contigs, also useful when removing conderecet super contigs
if [ ! $keepSuperContigs = 0 ] || [ ! $keepCondorcetSuperContigs = 0 ];
then
	echo "Removes subcontigs from .m4 : $((`date +%s`-start)) s"
	keepSuperContigsM4.sh "${m4Input}" > "${m4Input%.m4}.superContigs.m4"
	m4Input="${m4Input%.m4}.superContigs.m4"
fi

## In .m4 file keep the contigs thats in contigs2remove list
if [ ! $contigMaxOverlapFrequency = 0 ] || [ ! $contigMaxOverlapRatio = 0 ] || [ ! $keepCondorcetSuperContigs = 0 ]
then
	echo "Removes appended contigs from .m4 : $((`date +%s`-start)) s"
	sort -u "${contigs2remove}" > "${contigs2remove}.sort-u"
	OUTPUTFILE="${m4Input%.m4}${FREQ}${RATIO}${CONDERCET}.m4"
	removeContigsM4.sh "${contigs2remove}.sort-u" "${m4Input}" > $OUTPUTFILE
fi

## Script finished

## Elapsed time
end=`date +%s`
runtime=$((end-start))
rumtimeM=$((runtime / 60))
echo $runtime seconds > $1.nDest.rTime
echo "Script is completed. Duration $rumtimeM minutes."
echo "Output file is: $OUTPUTFILE"
#spd-say -i -50 -p -100 -t male2 'Script is completed. Duration '$rumtimeM' minutes.'
