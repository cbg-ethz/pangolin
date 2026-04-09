#!/usr/bin/env bash

set -euo pipefail

# List of batches
readonly BATCHES=(
    "20260320_o41461"
)

# Log file
logfile="20260409_garbage_batches_vpipe_input.log"

echo "==== Starting batch run $(date '+%Y-%m-%d %H:%M:%S') ====" >> "$logfile"

for batch in "${BATCHES[@]}"; do
        
        echo "" >> "$logfile"
        echo "---- $(date '+%Y-%m-%d %H:%M:%S') : Running on $batch ----" >> "$logfile"
        
        # Run the command; append both stdout and stderr to the log
        ./garbage_vpipe_input.sh --batch "$batch" >> "$logfile" 2>&1
done

echo "==== Finished $(date '+%Y-%m-%d %H:%M:%S') ====" >> "$logfile"

