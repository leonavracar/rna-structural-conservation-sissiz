#!/bin/bash

# Usage: ./csv_output.sh sissiz_output_B.txt > summary_B.csv

INPUT="$1"

echo "Filename;Z1;Z2;Z3;Z4"

awk -F'\t' '
{
  # Get filename from path (2nd field)
  split($2, parts, "/")
  fname = parts[length(parts)]
  
  # Get z-score (13th field)
  z = $13
  
  # Append to current block
  scores[fname] = (scores[fname] == "" ? z : scores[fname] ";" z)
  
  count[fname]++
}
END {
  for (f in scores) {
    if (count[f] == 4) {
      print f ";" scores[f]
    } else {
      print f ";INCOMPLETE_BLOCK" > "/dev/stderr"
    }
  }
}
' "$INPUT" | sort
