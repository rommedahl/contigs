# contigs
Project on identifying sets of overlapping pieces of DNA using graph algorithms.

1. Filter data set using main.sh, instructions documented in script

2. Pipe filtered data to graph_representation with syntax (standing in main contigs folder)

    cat path/to/data | python bin/graph_representation.py -stdin

    alternatively the graph structure can be set to read a set amount of lines, for example

    cat path/to/data | python bin/graph_representation.py lines=10000 -stdin

Script outputs a file called Partitions_size.txt where size is a number indicating amount of partitions. Data in file
is structured as follows. Also prints time used by script to stdout

    Size of partition 1   (amount of contigs id's in partition)
    Id1                 (all id's of contigs in partition)
    Id2
    .
    .
    .
    \n
    Size of partition 2
    Id1
    .
    .
    .
    \n
