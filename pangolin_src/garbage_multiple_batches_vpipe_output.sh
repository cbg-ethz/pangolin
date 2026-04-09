#!/usr/bin/env bash

set -euo pipefail

# List of batches
readonly BATCHES=(
    "20260325_2531482360"
)

# Variants to run
#readonly VARIANTS=("IA_H1" "IA_H3" "IA_MP" "IA_N1" "IA_N2")
readonly VARIANTS=("IA_N1")

# Log file
logfile="20260409_garbage_batches_IA_N1.log"

echo "BATCHES: ${BATCHES}" >> "$logfile"
echo "VARIANTS: ${VARIANTS}" >> "$logfile"

echo "==== Starting batch run $(date '+%Y-%m-%d %H:%M:%S') ====" >> "$logfile"

for batch in "${BATCHES[@]}"; do
    for variant in "${VARIANTS[@]}"; do
        
        echo "" >> "$logfile"
        echo "---- $(date '+%Y-%m-%d %H:%M:%S') : Running $variant on $batch ----" >> "$logfile"
        
        # Run the command; append both stdout and stderr to the log
        ./garbage.sh --variant "$variant" --batch "$batch" >> "$logfile" 2>&1
    done
done

echo "==== Finished $(date '+%Y-%m-%d %H:%M:%S') ====" >> "$logfile"

