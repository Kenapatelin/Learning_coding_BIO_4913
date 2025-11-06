#!/bin/bash

# Store the input file name in a variable
GENE="SLF_genomic.gff"

# Create the output file with header line
echo -e "Chromosome\tGeneCount\tClass" > density_report.txt

# Get unique chromosome names (skip header lines)
chromosomes=($(awk '!/^#/' "$GENE" | awk '{print $1}' | sort | uniq))

# Loop through each chromosome
for chr in "${chromosomes[@]}"
do

# Count number of genes for this chromosome
    gene_count=$(awk -v c="$chr" '!/^#/ && $1 == c && $3 == "gene"' "$GENE" | wc -l)

# Classify density
    if [ "$gene_count" -gt 2000 ]; then
        density="High-density"
    else
        density="Low-density"
    fi

# Write to report file
    echo -e "${chr}\t${gene_count}\t${density}" >> density_report.txt
done

# Print completion message
echo "Density report complete. Results saved to density_report.txt"

