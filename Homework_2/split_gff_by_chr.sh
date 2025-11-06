#!/bin/bash

# Store the input file name in a variable
GENE="SLF_genomic.gff"

# Create a file listing all unique chromosome IDs from column 1
awk '!/^#/' "$GENE" | awk '{print $1}' | sort | uniq > chromosomes.txt

# Use a while loop to read each chromosome ID
while read chr
do

# Save all lines for that chromosome into a new file
    awk -v c="$chr" '$1 == c' "$GENE" > "${chr}.gff"
    
# Print status message
    echo "Wrote ${chr}.gff"

done < chromosomes.txt
