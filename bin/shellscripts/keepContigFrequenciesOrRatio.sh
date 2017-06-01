#!/bin/bash
# Keep contigs with overlap frequency within range.
# keepContigFrequency.sh -l loverValue -u upperValue [filename]
#
# Input:  Contig Id and frequency
# Output: Contig Id

# Inhämtning av argument
# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash/13359121?noredirect=1#comment29656357_13359121
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -l|--lower)
    LOWER="$2"
    shift # past argument
    ;;
    -u|--upper)
    UPPER="$2"
    shift # past argument
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

if [ -z ${LOWER+x} ]; then echo "Lover bound not set in keepLength"; exit; fi
if [ -z ${UPPER+x} ]; then echo "Upper bound not set in keepLength"; exit; fi

awk -v lower=$LOWER -v upper=$UPPER '{if (lower<=$2 && $2<=upper) print $1}' $1
