#!/bin/bash

# Initialize the output file with headers
output_file="stats.csv"
echo "Timestamp,Container,CPU_Percentage,Memory_Percentage" > $output_file

# Get the end time (current time + 5 minutes)
end_time=$(( $(date +%s) + 300 ))

# Start collecting stats
while [ $(date +%s) -lt $end_time ]; do
    # Get the current time
    timestamp=$(date '+%H:%M:%S')
    
    # Get docker stats and format it as CSV
    docker stats lb --format "{{.Container}},{{.CPUPerc}},{{.MemPerc}}" --no-stream | \
    while IFS= read -r stats; do
        echo "$timestamp,$stats" | tee -a $output_file
    done
    
    # Sleep for a short interval to avoid hammering the system (e.g., 1 second)
    sleep 1
done

echo "Data collection completed. The script has run for 5 minutes."
