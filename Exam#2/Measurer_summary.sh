#!/bin/bash

#Storing input and output file in two different variables
INPUT="Exam2_Levine_et_al_body_size.csv"                     
OUTPUT="Measurer_summary_output.txt"                         

# Removed header row
cleaned=$(tail -n +2 "$INPUT")

# Get unique measurer initials
measurers=$(echo "$cleaned" | cut -d',' -f1 | sort -u)

#Get unique site codes
sites=$(echo "$cleaned" | cut -d',' -f2 | sort -u)        

#Array to store each site's class
declare -A site_class                  

# Starting loop code 
for site in $sites; do                                       # Loop through each site code
    ip=$(echo "$cleaned" | grep ",$site," | head -n 1 | cut -d',' -f5)   # Extract IP value for site
    ip=$(echo "$ip" | tr -d ' \r\t')                         # Clean whitespace/hidden characters

    if [ "$ip" -lt 15 ]; then                                # Rural classification rule
        site_class["$site"]="Rural"
    elif [ "$ip" -le 49 ]; then                              # Suburban classification rule
        site_class["$site"]="Suburban"
    else                                                     # Urban classification rule
        site_class["$site"]="Urban"
    fi
done

# Write header for output table
echo -e "Measurer\t#Samples\t#Rural\t#Suburban\t#Urban" > "$OUTPUT"   # Header row

# Summaries per Measurer
for m in $measurers; do                                      # Loop through each measurer
    rows=$(echo "$cleaned" | grep "^$m,")                    # All rows measured by this measurer
    total=$(echo "$rows" | wc -l)                            # Total samples measured

    rural=0                                                  # Initialize counters
    suburban=0
    urban=0

    while IFS=',' read -r meas site sex length ip; do        # Read each record for this measurer
        class="${site_class[$site]}"                         # Look up site class

        if [ "$class" = "Rural" ]; then                      # Increment rural count
            rural=$((rural+1))
        elif [ "$class" = "Suburban" ]; then                 # Increment suburban count
            suburban=$((suburban+1))
        else                                                 # Increment urban count
            urban=$((urban+1))
        fi

    done <<< "$rows"                                       # Feed all measurer’s rows into loop

    printf "%-10s\t%-8s\t%-6s\t%-9s\t%-5s\n" "$m" "$total" "$rural" "$suburban" "$urban" >> "$OUTPUT"   # Write aligned row
done

# Status message
echo "Measurer summary written to $OUTPUT" 

