#!/bin/bash

# Storing input file in variable INPUT and output file in OUTPUT.
INPUT="Exam2_Levine_et_al_body_size.csv"
OUTPUT="sampling_summary_output.txt"

# Count unique sites and write the result to the output file
echo -e "Number of sites:\t$(cut -d',' -f2 "$INPUT" | sort -u | wc -l)" > "$OUTPUT"

# Add a blank line for readability
echo "" >> "$OUTPUT"              
         
# Print the header row with aligned columns
printf "%-12s\t%-10s\t%-10s\t%-10s\n" "Site_Code" "N_Samples" "N_Males" "N_Females" >> "$OUTPUT"   

for site in $(cut -d',' -f2 "$INPUT" | sort -u); do                       # Loop through each unique site code
    total=$(grep ",$site," "$INPUT" | wc -l)                              # Count all samples collected at this site
    males=$(grep ",$site,M," "$INPUT" | wc -l)                            # Count all male (M) samples at this site
    females=$(grep ",$site,F," "$INPUT" | wc -l)                          # Count all female (F) samples at this site

# Print the summary row for this site
    printf "%-12s\t%-10s\t%-10s\t%-10s\n" "$site" "$total" "$males" "$females" >> "$OUTPUT"
done                                                                                     # End of site loop
