#!/bin/bash

#Storing Input file and output file in two different vsriables named INPUT and OUTPUT
INPUT="Exam2_Levine_et_al_body_size.csv"                    
OUTPUT="largest_individual_output.txt"                       

awk -F',' 'NR>1 {                                            # Use comma as delimiter, skip header (NR>1)
    if ($3 == "M" && $4 > max_male_len) {                    # If this row is male and longer than current max
        max_male_len = $4;                                   #   update longest male length
        max_male_site = $2;                                  #   update site where longest male was found
    }
    if ($3 == "F" && $4 > max_female_len) {                  # If this row is female and longer than current max
        max_female_len = $4;                                 #   update longest female length
        max_female_site = $2;                                #   update site where longest female was found
    }
}
END {
    print "Longest male length: " max_male_len " mm";         # Print longest male length
    print "Collected at site: " max_male_site;                # Print site for longest male
    print "";                                                 # Blank line

    print "Longest female length: " max_female_len " mm";     # Print longest female length
    print "Collected at site: " max_female_site;              # Print site for longest female
    print "";                                                 # Blank line

    if (max_male_site == max_female_site) {                   # Compare male and female sites
        print "Longest male and female were collected at the SAME site."; 
    } else {
        print "Longest male and female were collected at DIFFERENT sites.";
    }
}' "$INPUT" > "$OUTPUT"                                      # Run awk on INPUT and write to OUTPUT


# Status message to inidicate the code was able ro run successfully
echo "Largest individual summary written to $OUTPUT"         


