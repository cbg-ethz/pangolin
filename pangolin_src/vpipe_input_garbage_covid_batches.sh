#!/usr/bin/env bash

# List of batches
batches=(
    "20251031_2447500361"
    "20251114_2511440485"
    "20251003_2447646564"
    "20251017_2447441696"
)

# Log file
logfile="run_batches_vpipe_input.log"

echo "==== Starting batch run $(date '+%Y-%m-%d %H:%M:%S') ====" >> "$logfile"

for batch in "${batches[@]}"; do
        
        echo "" >> "$logfile"
        echo "---- $(date '+%Y-%m-%d %H:%M:%S') : Running on $batch ----" >> "$logfile"
        
        # Run the command; append both stdout and stderr to the log
        ./garbage_vpipe_input.sh --batch "$batch" >> "$logfile" 2>&1
done

echo "==== Finished $(date '+%Y-%m-%d %H:%M:%S') ====" >> "$logfile"

