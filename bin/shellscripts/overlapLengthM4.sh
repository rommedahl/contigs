#!/bin/bash
# Keeps overlaps when the length of both contigs are within specified range.
# keepLength.sh -l loverValue -u upperValue [filename]
#
# Input:  Standard input with file or stream of .m4 format.
# Output: Standard output

awk '{print int((($7-$6)+($11-$10))/2)}' $1

