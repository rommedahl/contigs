#!/bin/bash

# User input ###################################################################

# Enter path to .m4 input data
m4File=data/sample.m4

# Sorting - Removes duplicate overlaps.
##1 = yes (recommended), 0 = no
m4sorting=0

# Max and min number of overlaps for each contig. Max = 0 > no restriction.
contigMaxOverlapFrequency=0
contigMinOverlapFrequency=0

# Max and min overlap ratio for each contig.  Max = 0 > no restriction.
contigMaxOverlapRatio=0
contigMinOverlapRatio=0

# Keep overlaps when none of the contigs are completely overlapped by the other.
# 1 = yes (recommended), 0 = no
keepSuperContigs=0

# Only keep contigs that never are completely overlapped by another contig.
keepCondorcetSuperContigs=0

# Code #########################################################################

echo "Script is running"
start=`date +%s`

PATH=$PATH:bin:bin/shellscripts # Add path to script folders

m4Input="${m4File}"	# Sets the input pointer to be the data file.
m4InputBase="${m4File%.m4}"

# Start message.

# Sorting if sorted output file does not already exist. 
if [ ! $m4sorting = 0 ]
then
	echo "Sorting .m4 file : $((`date +%s`-start)) s"
	if [ ! -f "${m4InputBase}.sort.m4" ]; then sortM4.sh "${m4Input}" > "${m4InputBase}.sort.m4"; fi # Sorts to new filename
	m4Input="${m4InputBase}.sort.m4" # Sets the input pointer to the new file name
elif [ $m4sorting = 0 ]
then
	: # Do nothing
else
	echo "Setting for sorting not valid. Abort."
	exit
fi

# Create file with contig data if to make frequency or ratio filtering.
if [ ! $contigMaxOverlapFrequency = 0 ] || [ ! $contigMaxOverlapRatio = 0 ]
then
	echo "Create contig file : $((`date +%s`-start)) s"
	contigInput="${m4InputBase}.contigData" # Create file name for contig data
	if [ ! -f "${contigInput}" ]
	then
		catContigsM4.sh "${m4Input}" > "${contigInput}.temp"
		sort "${contigInput}.temp" > "${contigInput}"
		rm "${contigInput}.temp"
	fi # Add data to that file
fi

# Create empty file to append contigs that to later be removed
if [ ! $contigMaxOverlapFrequency = 0 ] || [ ! $contigMaxOverlapRatio = 0 ] || [ ! $keepCondorcetSuperContigs = 0 ]
then
	contigs2remove="${m4InputBase}.contigs2remove" # File name for list of contigs to remove
	echo > "${contigs2remove}" # Empty file with that name
fi

# (CondorcetS)Subcontigs to remove sent to remove list
if [ ! $keepCondorcetSuperContigs = 0 ];
then
	echo "Appends subcontigs for removal : $((`date +%s`-start)) s"
	subContigsM4.sh "${m4Input}" >> "${contigs2remove}"
	CONDERCET=".noSubContigs"
fi

# Overlap frequencies to remove
if [ ! $contigMaxOverlapFrequency = 0 ];
then
	echo "Appends contigs outside overlap frequency range for removal : $((`date +%s`-start)) s"
	if [ ! -f "${contigInput}.overlapFrequency" ]
	then
		contigOverlapFrequencyLength.sh "${contigInput}" > "${contigInput}.overlapFrequency" # File with contig frequency and length
	fi
	contigsOutsideBound.sh -l "${contigMinOverlapFrequency}" -u "${contigMaxOverlapFrequency}" "${contigInput}.overlapFrequency" >> "${contigs2remove}" # Add contigs outside range to removelist
	FREQ=".freq"
fi

# Overlap ratios to remove
if [ ! $contigMaxOverlapRatio = 0 ];
then
	echo "Appends contigs above max overlap ratio for removal : $((`date +%s`-start)) s"
	contigOverlapRatio.sh "${contigInput}" > "${contigInput}.overlapRatio" # File with contig overlap ratio
	contigsOutsideBound.sh -l "${contigMinOverlapRatio}" -u "${contigMaxOverlapRatio}" "${contigInput}.overlapRatio" >> "${contigs2remove}" # Add contigs outside range to removelist
	RATIO=".ratio"
fi

# Keep only overlaps without sub contigs, also useful when removing conderecet super contigs
if [ ! $keepSuperContigs = 0 ] || [ ! $keepCondorcetSuperContigs = 0 ];
then
	echo "Removes suboverlaps from .m4 : $((`date +%s`-start)) s"
	removeSubOverlapsM4.sh "${m4Input}" > "${m4Input%.m4}.noSubOverlaps.m4"
	m4Input="${m4Input%.m4}.noSubOverlaps.m4"
fi

# In .m4 file keep the contigs thats in contigs2remove list
if [ ! $contigMaxOverlapFrequency = 0 ] || [ ! $contigMaxOverlapRatio = 0 ] || [ ! $keepCondorcetSuperContigs = 0 ]
then
	echo "Removes appended contigs from .m4 : $((`date +%s`-start)) s"
	sort -u "${contigs2remove}" > "${contigs2remove}.sort-u"
	OUTPUTFILE="${m4Input%.m4}${FREQ}${RATIO}${CONDERCET}.m4"
	removeContigsM4.sh "${contigs2remove}.sort-u" "${m4Input}" > $OUTPUTFILE
else
		OUTPUTFILE="${m4Input%.m4}.m4"
fi

# Script finished

# Elapsed time
end=`date +%s`
runtime=$((end-start))
rumtimeM=$((runtime / 60))
echo $runtime seconds > $1.nDest.rTime
echo "Script is completed. Duration $rumtimeM minutes."
echo "Output file is: $OUTPUTFILE"
spd-say -i -50 -p -100 -t male2 'Script is completed. Duration '$rumtimeM' minutes.'
