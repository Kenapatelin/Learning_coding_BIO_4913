#!/bin/bash

# feature_inventory.sh
# Usage: ./feature_inventory.sh

# Store the input file name in a variable
GENE="SLF_genomic.gff"

# Remove comment lines and count total features
total=$(awk '!/^#/' "$GENE" | wc -l)

# Count the number of features of each type based on column 3
genes=$(awk '!/^#/ && $3=="gene"' "$GENE" | wc -l)
mrnas=$(awk '!/^#/ && $3=="mRNA"' "$GENE" | wc -l)
exons=$(awk '!/^#/ && $3=="exon"' "$GENE" | wc -l)

# Print report to standard output
echo "Total number of features: $total"
echo -e "gene:\t$genes"
echo -e "mRNA:\t$mrnas"
echo -e "exon:\t$exons"

