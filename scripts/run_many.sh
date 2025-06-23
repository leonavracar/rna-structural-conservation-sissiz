#!/bin/bash

N=1000  # Change to 100 or 1000 for more runs

FILES=(
  "/home/leona/Strukturvorhersagen/Project_2/A_output/A_clustal_n20_file0083_sample12.aln"
  "/home/leona/Strukturvorhersagen/Project_2/B/B_n20_file0083_sample12.aln"
  "/home/leona/Strukturvorhersagen/Project_2/C/C_n20_file0083_sample12.aln"
)

PARAMS=(
  "--mono"
  "--mono -j"
  "--di"
  "--di -j"
)

for FILE in "${FILES[@]}"; do
  if [[ -f "$FILE" ]]; then
    BASENAME=$(basename "$FILE" .aln)
    OUTFILE="${BASENAME}_SISSIz_avg_scores.txt"
    echo "===== Averaged Z-scores and SCI for $FILE (N=$N) =====" > "$OUTFILE"

    for PARAM in "${PARAMS[@]}"; do
      echo "Running $PARAM $N times..."
      SUM_Z=0
      SUM_SCI=0
      COUNT=0

      for ((i=1; i<=N; i++)); do
        OUTPUT=$(SISSIz $PARAM --sci "$FILE" 2>/dev/null)
        if [[ $? -eq 0 ]]; then
          Z=$(echo "$OUTPUT" | awk '{print $NF}')
          SCI=$(echo "$OUTPUT" | awk '{print $(NF-5)}')
          if [[ "$Z" =~ ^-?[0-9]+(\.[0-9]+)?$ ]] && [[ "$SCI" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
            SUM_Z=$(echo "$SUM_Z + $Z" | bc)
            SUM_SCI=$(echo "$SUM_SCI + $SCI" | bc)
            COUNT=$((COUNT + 1))
          fi
        fi
      done

      if [[ $COUNT -gt 0 ]]; then
        AVG_Z=$(echo "scale=4; $SUM_Z / $COUNT" | bc)
        AVG_SCI=$(echo "scale=4; $SUM_SCI / $COUNT" | bc)
        echo "$PARAM → Avg z-score: $AVG_Z, Avg SCI: $AVG_SCI (n=$COUNT)" >> "$OUTFILE"
      else
        echo "$PARAM → Failed all $N runs." >> "$OUTFILE"
      fi
    done

    echo "✅ Done: $OUTFILE"
    echo "----------------------------------"
  else
    echo "❌ File not found: $FILE"
  fi
done
