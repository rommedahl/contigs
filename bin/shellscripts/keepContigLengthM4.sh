#!/bin/bash
# Keeps overlaps when the length of both contigs are within specified range.
# keepLength.sh -l loverValue -u upperValue [filename]
#
# Input:  Standard input with file or stream of .m4 format.
# Output: Standard output

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

#echo "${LOWER}"
#echo "${UPPER}"
awk -v lower=$LOWER -v upper=$UPPER '{if ( (lower<=$8 && $8<=upper) && (lower<=$12 && $12<=upper) ) print $0}' $1
