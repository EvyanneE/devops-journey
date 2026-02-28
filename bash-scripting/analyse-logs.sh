#!/usr/bin/env bash

set -a          # automatically export all variables
source .env     # load variables
set +a          # stop automatically exporting all variables

echo "analysing log files" > "$REPORT_FILE"
echo "===============================================================================================" >> "$REPORT_FILE"

echo -e "\nList of log files updated in the last 24 hours" >> "$REPORT_FILE"
LOG_FILES=$(find $LOG_DIR -name "*.log" -mtime -1)
echo "$LOG_FILES" >> "$REPORT_FILE"

for LOG_FILE in $LOG_FILES; do

    echo -e "\n" >> "$REPORT_FILE"
    echo "===============================================================================================" >> "$REPORT_FILE"
    echo "$LOG_FILE" >> "$REPORT_FILE"
    echo "===============================================================================================" >> "$REPORT_FILE"

    for PATTERN in ${ERROR_PATTERNS[@]}; do # make sure to expand the array variable
        # print and count
        echo -e "\nsearching $PATTERN logs in $LOG_FILE file" >> "$REPORT_FILE"
        grep "$PATTERN" "$LOG_FILE" >> "$REPORT_FILE"

        echo -e "\nNumber of  $PATTERN  logs found in $LOG_FILE" >> "$REPORT_FILE"
        ERROR_COUNT=$(grep -c  "$PATTERN" "$LOG_FILE")
        echo $ERROR_COUNT >> "$REPORT_FILE"

        if [[ "$ERROR_COUNT" -gt 10 ]]; then 
            echo -e "\n ⚠️ Action Required: too many $PATTERN issues in log file $LOG_FILE"
        fi
    done
done

echo -e "/nLog analysis completed and report saved in $REPORT_FILE"