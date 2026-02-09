#!/bin/bash

INPUT_FILE="$1"
OUTPUT_FILE="output.txt"

# Clear output file if it already exists
> "$OUTPUT_FILE"

# Temporary variables
frame_time=""
fc_type=""
fc_subtype=""

while IFS= read -r line
do
    if [[ $line == *"frame.time"* ]]; then
        frame_time=$(echo "$line" | sed -n 's/.*"frame.time":[[:space:]]*"\(.*\)".*/\1/p')
    fi

    if [[ $line == *"wlan.fc.type"* ]]; then
        fc_type=$(echo "$line" | sed -n 's/.*"wlan.fc.type":[[:space:]]*"\(.*\)".*/\1/p')
    fi

    if [[ $line == *"wlan.fc.subtype"* ]]; then
        fc_subtype=$(echo "$line" | sed -n 's/.*"wlan.fc.subtype":[[:space:]]*"\(.*\)".*/\1/p')
    fi

    # Once all three are captured, write to output
    if [[ -n $frame_time && -n $fc_type && -n $fc_subtype ]]; then
        {
            echo "\"frame.time\": \"$frame_time\","
            echo "\"wlan.fc.type\": \"$fc_type\","
            echo "\"wlan.fc.subtype\": \"$fc_subtype\""
            echo
        } >> "$OUTPUT_FILE"

        # Reset for next frame
        frame_time=""
        fc_type=""
        fc_subtype=""
    fi

done < "$INPUT_FILE"

