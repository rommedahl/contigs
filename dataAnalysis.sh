#!/bin/bash

# Execute with ./dataAnalysis.sh filename. Ska ersätta contig.sh.

echo 'Data analysis'

start=`date +%s`

cat $1 |
	tee >(wc -l > $1.rows.N) |	# Antal rader i filen
uniq |
	tee >(wc -l > $1.rows.unique.N) >(awk '{print $1"	"$2}' | uniq | wc -l > $1.overlaps.presort.unique.N ) |	# Antal unika rader. Antal unika ID-rader.
awk '{if ($1>$2) print $2"	"$1; else print $1"	"$2}' |
sort --parallel=6 |
	tee >(wc -l > $1.overlaps.N) >(uniq | wc -l > $1.overlaps.unique.N) >(uniq -d > $1.overlaps.duplicates) |	# Antal unika kopplingar mellan kontiger
awk '{OFS="\n"};{print $1,$2}' | sort --parallel=6 | uniq -c | 
	tee >(sort -nr | awk '{print $2" "$1}' > $1.IDs.freq) |	# Tabell över förekomster av varje contig
awk '{print $2}' | uniq |
	tee >(cat > $1.IDs.unique) | # Unika contig ID
wc -l > $1.IDs.unique.N	# Antal unika contig ID

# Tidsåtgång, verkar ej fungera
end=`date +%s`
runtime=$((end-start))
echo $runtime minuter> $1.runtime

