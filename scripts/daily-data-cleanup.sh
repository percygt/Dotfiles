#! /bin/bash

set -eu
set -o pipefail

readonly DAILY_DIR="/backup/daily"
readonly WEEKLY_DIR="/backup/weekly"
readonly MONTHLY_DIR="/backup/monthly"
readonly LOG_DIR="/data/logs"
readonly LOG_FILE="${LOG_DIR}/daily-data-cleanup.log"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
	local timestamp
	timestamp=$(date '+%Y-%m-%d %H:%M:%S')
	echo "[$timestamp] $1" >>"$LOG_FILE"
	echo "[$timestamp] $1"
}

# Log start of cleanup
log_message "Starting daily cleanup"

# Remove daily backups older than a certain period (e.g., 7 days)
find "$DAILY_DIR"/* -maxdepth 0 -type d -mtime +5 -exec rm -rf {} \; >>"$LOG_FILE" 2>&1

# Iterate through each directory
for dir in "$DAILY_DIR"/*; do
	if [ "$dir" == "latest" ]; then
		continue
	fi
	# Ignore the 'latest' directory
	# Extract date from the directory path
	date_part=$(basename "$dir" | cut -d_ -f1)

	# Create an associative array to store the latest timestamp for each date
	declare -A latest_timestamps

	# Check if the current directory has a later timestamp
	if [[ "${latest_timestamps[$date_part]}" < "$(basename "$dir")" ]]; then
		# Delete the previously stored directory
		if [ "${latest_timestamps[$date_part]}" != "" ]; then
			rm -rf "${DAILY_DIR:?}/${latest_timestamps[$date_part]}"
			echo "${DAILY_DIR}/${latest_timestamps[$date_part]}"
		fi

		# Update the latest timestamp for the current date
		latest_timestamps[$date_part]=$(basename "$dir")
	else
		# If the current directory has an earlier timestamp, delete it
		rm -rf "$dir"
		echo "$dir"
	fi
done
# Log completion of cleanup
log_message "Daily cleanup completed"

# Create weekly backup on Sundays
if [ "$(date '+%u')" -eq 7 ]; then
	# Log start of cleanup
	log_message "Starting weekly cleanup"

	# Remove weekly backups older than a certain period (e.g., 4 weeks)
	find "$WEEKLY_DIR"/* -maxdepth 0 -type d -mtime +28 -exec rm -rf {} \; >>"$LOG_FILE" 2>&1

	# Log completion of cleanup
	log_message "Weekly cleanup completed"
fi

# Create monthly backup on the 1st day of the month
if [ "$(date '+%d')" -eq 1 ]; then
	# Log start of cleanup
	log_message "Starting monthly cleanup"

	# Remove monthly backups older than a certain period (e.g., 6 months)
	find "$MONTHLY_DIR"/* -maxdepth 0 -type d -mtime +180 -exec rm -rf {} \; >>"$LOG_FILE" 2>&1

	# Log completion of cleanup
	log_message "Monthly cleanup completed"
fi
