#!/usr/bin/env bash

set -euo pipefail

# List of batches
readonly BATCHES=(
    "20260320_o41461"
)

# Variants to run
readonly VARIANTS=("RSVA" "RSVB")

# Log file
logfile="20260409_garbage_batches.log"

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

