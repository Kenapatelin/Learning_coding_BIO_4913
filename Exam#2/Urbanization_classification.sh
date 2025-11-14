#!/bin/bash

#Storing INPUT and OUTPUT file in two different variables
INPUT="Exam2_Levine_et_al_body_size.csv"
OUTPUT="Urbanization_classification.txt"

sites=$(cut -d',' -f2 "$INPUT" | tail -n +2 | sort -u)    # Get unique site codes (skip header)

printf "%-12s\t%-10s\n" "Site_Code" "Class" > "$OUTPUT"    # Print header row with alignment

for site in $sites; do                                     # Loop over each site

    # Extract the IP-5KM value for this site (column 5)
    ip=$(grep ",$site," "$INPUT" | head -n 1 | cut -d',' -f5)   # Pull IP column

    ip=$(echo "$ip" | tr -d '\r' | tr -d ' ' | tr -d '\t')      # Remove all hidden characters

    # Convert to integer-friendly format
    ip=$(printf "%d" "$ip" 2>/dev/null)                         # Force numeric, strip stray chars

    if [ "$ip" -lt 15 ]; then                                   # Rural classification rule (<15)
        class="Rural"
    elif [ "$ip" -le 49 ]; then                                 # Suburban classification rule (15–49)
        class="Suburban"
    else                                                        # Urban classification rule (>50)
        class="Urban"
    fi

    printf "%-12s\t%-10s\n" "$site" "$class" >> "$OUTPUT"       # Print aligned site and  class
done                                                            # End loop

echo "Urbanization classification written to $OUTPUT"           # Status message
