#!/bin/bash

# Usage: ./sissiz_runner.sh B

FOLDER=$1
BASE="/home/leona/Strukturvorhersagen/Project_3"
INPUT_PATH="$BASE/$FOLDER/20"
OUTPUT="sissiz_output_${FOLDER}.txt"

# Clear or create the output file
> "$OUTPUT"

# Loop through all .aln files in the 20 subfolder
find "$INPUT_PATH" -type f -name "*.aln" | sort | while read -r FILE; do
  SISSIz --mono --sci "$FILE" >> "$OUTPUT"
  SISSIz --mono -j --sci "$FILE" >> "$OUTPUT"
  SISSIz --di --sci "$FILE" >> "$OUTPUT"
  SISSIz --di -j --sci "$FILE" >> "$OUTPUT"
done
