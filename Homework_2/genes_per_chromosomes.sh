#! /bin/bash

#creating a variable to store file name in it
GENE="SLF_genomic.gff"

# Create an array of unique chromosome names from column 1
chromosomes=($(awk '{print $1}' "$GENE" | sort | uniq))

# Print header
echo -e "Chromosome\tGeneCount"

# create an array of unique chromosome names
chromosomes=($(grep -v '^#' "$GENE" | awk '{print $1}' | sort | uniq))

# Loop through the array of chromosomes
for chr in "${chromosomes[@]}"; do
    
# Count how many lines in the file have this chromosome AND the word 'gene'
    count=$(grep -w "$chr" "$GENE" | grep -w "gene" | wc -l)
    echo -e "${chr}\t${count}"
done
