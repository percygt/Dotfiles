#! /bin/bash

set -o errexit
set -o nounset
set -o pipefail

readonly DAILY_DIR="/backup/daily"
readonly WEEKLY_DIR="/backup/weekly"
readonly MONTHLY_DIR="/backup/monthly"
readonly LOG_DIR="${HOME}/Logs"
readonly LOG_CLEANUP="${LOG_DIR}/data_cleanup.log"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] $1" >> "$LOG_CLEANUP"
  echo "[$timestamp] $1"
}

# Log start of cleanup
log_message "Starting daily cleanup"

# Remove daily backups older than a certain period (e.g., 7 days)
find "$DAILY_DIR"/* -maxdepth 0 -type d -mtime +7 -exec rm -rf {} \; >> "$LOG_CLEANUP" 2>&1

# Log completion of cleanup
log_message "Daily cleanup completed"

# Create weekly backup on Sundays
if [ "$(date '+%u')" -eq 7 ]; then
# Log start of cleanup
  log_message "Starting weekly cleanup"

  # Remove weekly backups older than a certain period (e.g., 4 weeks)
  find "$WEEKLY_DIR"/* -maxdepth 0 -type d -mtime +28 -exec rm -rf {} \; >> "$LOG_CLEANUP" 2>&1

  # Log completion of cleanup
  log_message "Weekly cleanup completed"
fi

# Create monthly backup on the 1st day of the month
if [ "$(date '+%d')" -eq 1 ]; then
  # Log start of cleanup
  log_message "Starting monthly cleanup"

  # Remove monthly backups older than a certain period (e.g., 6 months)
  find "$MONTHLY_DIR"/* -maxdepth 0 -type d -mtime +180 -exec rm -rf {} \; >> "$LOG_CLEANUP" 2>&1

  # Log completion of cleanup
  log_message "Monthly cleanup completed"
fi