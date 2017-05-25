#!/bin/bash

# Execute with ./dataAnalysis.sh filename. Ska ersätta contig.sh.

echo 'Data analysis'

start=`date +%s`

cat $1 |
	tee >(wc -l > $1.rows.N) |	# Antal rader i filen
awk '{print $1"	"$2}' |	# Behåller kolumn 1 och 2
	tee >(uniq | wc -l > $1.overlaps.unique.N) >(uniq -d > $1.overlaps.duplicates) |	# Antal unika kopplingar mellan kontiger samt en lista på överlapp som det finns dubletter av
awk '{OFS="\n"};{print $1,$2}' | sort --parallel=4 | uniq -c |	# Radbryter rader så att det blir en sorterad kolumn och summerar en frekvenstabell över förekomster av varje contig
	tee >(sort -nr | awk '{print $1"	"$2}' > $1.IDs.freq) |	#  Sorterar frekvenstabellen och skickar till fil
awk '{print $2}' | uniq |	# Skickar enbart ID-kolumnen
	tee >(cat > $1.IDs.unique) |	# Unika contig ID
wc -l > $1.IDs.unique.N	# Antal unika contig ID

# Tidsåtgång, verkar ej fungera
end=`date +%s`
runtime=$((end-start))
echo $runtime sekunder> $1.rtime

