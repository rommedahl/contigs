#!/bin/bash
# File to sort the .m4 file so that every row contains unique data and outputs to a file.

# TODO. Tee all information to variables that is later put into a summary file instead of separate files.

echo 'Non-destructive data reduction'

start=`date +%s`

if [ ! -f $1.ndest ]; then	# If the output file does not exist
	cat $1 |	# Cat the stdin
		tee >(wc -l > $1.N) |	# Print the number of lines to file
	uniq |	# Remove identical rows
		tee >(wc -l > $1.N.uniq) |	# Print number of identical lines to file
	#Sort the fields within each row for unique representation
	awk '{if ($1<$2) print $1"	"$2"	"$3"	"$4"	"$5"	"$6"	"$7"	"$8"	"$9"	"$10"	"$11"	"$12; else print $2"	"$1"	"$3"	"$4"	"$5"	"$10"	"$11"	"$12"	"$9"	"$6"	"$7"	"$8}' |
	sort --parallel=6 -u |	# Sort rows and make every row unique
		tee >(wc -l > $1.nDest.N) |	# Print number of lines of new dataset to file
	cat > $1.nDest	# Cat the output to file
fi

# Tidsåtgång
end=`date +%s`
runtime=$((end-start))
rumtimeM=$((runtime / 60))
echo $runtime seconds > $1.nDest.rTime
echo 'Script is completed. Duration '$rumtimeM' minutes.'
spd-say -i -50 -p -100 -t male2 'Script is completed. Duration '$rumtimeM' minutes.'
