#!/bin/bash

# List of input files
FILES=(
  "/home/leona/Strukturvorhersagen/Project_2/A_output/A_clustal_n20_file0083_sample12.aln"
  "/home/leona/Strukturvorhersagen/Project_2/B/B_n20_file0083_sample12.aln"
  "/home/leona/Strukturvorhersagen/Project_2/C/C_n20_file0083_sample12.aln"
)

# List of parameter combinations
PARAMS=(
  "--mono --sci"
  "--mono -j --sci"
  "--di --sci"
  "--di -j --sci"
)

# Loop through each file
for FILE in "${FILES[@]}"; do
  if [[ -f "$FILE" ]]; then
    echo "Processing: $FILE"
    BASENAME=$(basename "$FILE" .aln)
    OUTFILE="${BASENAME}_SISSIz_summary.txt"
    echo "Output → $OUTFILE"
    echo "===== SISSIz Output for $FILE =====" > "$OUTFILE"
    
    for PARAM in "${PARAMS[@]}"; do
      echo -e "\n--- Running: SISSIz $PARAM ---" >> "$OUTFILE"
      OUTPUT=$(SISSIz $PARAM "$FILE" 2>&1)
      EXIT_CODE=$?
      
      if [[ $EXIT_CODE -eq 0 ]]; then
        echo "$OUTPUT" >> "$OUTFILE"
      else
        echo "ERROR: Command failed: SISSIz $PARAM $FILE" >> "$OUTFILE"
        echo "Details: $OUTPUT" >> "$OUTFILE"
      fi
    done

    echo -e "\nAll runs finished for $FILE."
    echo "---------------------------------------------"
  else
    echo "File not found: $FILE — skipping."
  fi
done
