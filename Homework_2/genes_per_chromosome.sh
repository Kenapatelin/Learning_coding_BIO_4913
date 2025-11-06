#!/bin/bash/
# Store the input file name in a variable
GENE="SLF_genomic.gff"

# Print header
echo -e "Chromosome\tGeneCount"

# Extract chromosome names while skipping lines beginning with #
chromosomes=($(awk '!/^#/' "$GENE" | awk '{print $1}' | sort | uniq))

# For each chromosome, count gene features (ignoring comment lines)
for chr in "${chromosomes[@]}"
do
    gene_count=$(awk -v c="$chr" '!/^#/ && $1 == c && $3 == "gene"' "$GENE" | wc -l)
    echo -e "${chr}\t${gene_count}"
done
