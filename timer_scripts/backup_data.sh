#! /bin/bash

set -o errexit
set -o nounset
set -o pipefail

readonly SOURCE_DIR="/data"
readonly BACKUP_DIR="/backup"
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
readonly LOG_DIR="${HOME}/Logs"
readonly EXTENSIONS_DIR="${HOME}/.local/share/gnome-shell/extensions"
readonly EXTENSIONS_DUPE_DIR="/data/extensions"
readonly LOG_FILE="${LOG_DIR}/data_backup.log"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"
# chown -R 1000:root "$LOG_DIR"
# Function to log messages
log_message() {
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$timestamp] $1" >> "$LOG_FILE"
  echo "[$timestamp] $1"
}

# Log start of backup
log_message "Duplicating gnome-extensions"
rsync -av --delete \
    "${EXTENSIONS_DIR}" \
    "${EXTENSIONS_DUPE_DIR}" >> "$LOG_FILE" 2>&1
log_message "Duplication completed"


# Log start of backup
log_message "Starting backup for date: $DATETIME"
# Create daily backup
DAILY_DIR="${BACKUP_DIR}/daily"
DAILY_PATH="${BACKUP_DIR}/daily/${DATETIME}"
if [ ! -d "${DAILY_DIR}" ]; then
    # If it doesn't exist, create it
    mkdir "${DAILY_DIR}"
    chown -R 1000:root "${DAILY_DIR}"
    restorecon -R -v "${DAILY_DIR}"
    echo "Directory created: ${DAILY_DIR}"
fi
mkdir -p "${DAILY_PATH}"

rsync -av --delete \
    "${SOURCE_DIR}/" \
    --link-dest "${BACKUP_DIR}/daily/latest" \
    --exclude=".cache" \
    --exclude=".Trash-1000" \
    --exclude="/data/shared_home/Downloads/" \
    "${DAILY_PATH}" >> "$LOG_FILE" 2>&1


# Log completion of backup
log_message "Backup completed for date: $DATETIME"

# Create weekly backup on Sundays
if [ -d "${BACKUP_DIR}/daily/latest" ] && [ "$(date '+%u')" -eq 7 ]; then
  log_message "Creating weekly backup for date: $DATETIME"
  WEEKLY_DIR="${BACKUP_DIR}/weekly"
  WEEKLY_PATH="${BACKUP_DIR}/weekly/${DATETIME}"
  if [ ! -d "${WEEKLY_DIR}" ]; then
    # If it doesn't exist, create it
    mkdir "${WEEKLY_DIR}"
    chown -R 1000:root "${WEEKLY_DIR}"
    restorecon -R -v "${WEEKLY_DIR}"
    echo "Directory created: ${WEEKLY_DIR}"
  fi
  mkdir -p "${WEEKLY_PATH}"
  rsync -av --delete \
    "${SOURCE_DIR}/" \
    --link-dest "${BACKUP_DIR}/daily/latest" \
    --exclude=".cache" \
    --exclude=".Trash-1000" \
    --exclude="/data/shared_home/Downloads/" \
    "${WEEKLY_PATH}"


  # Log completion of weekly backup
  log_message "Weekly backup completed for date: $DATETIME"
fi

# Create monthly backup on the 1st day of the month
if [ -d "${BACKUP_DIR}/daily/latest" ] && [ "$(date '+%d')" -eq 1 ]; then
  log_message "Creating monthly backup for date: $DATETIME"
  MONTHLY_DIR="${BACKUP_DIR}/monthly"
  MONTHLY_PATH="${BACKUP_DIR}/monthly/${DATETIME}"
  if [ ! -d "${MONTHLY_DIR}" ]; then
    # If it doesn't exist, create it
    mkdir "${MONTHLY_DIR}"
    chown -R 1000:root "${MONTHLY_DIR}"
    restorecon -R -v "${MONTHLY_DIR}"
    echo "Directory created: ${MONTHLY_DIR}"
  fi
  mkdir -p "${MONTHLY_PATH}"
  rsync -av --delete \
    "${SOURCE_DIR}/" \
    --link-dest "${BACKUP_DIR}/daily/latest" \
    --exclude=".cache" \
    --exclude=".Trash-1000" \
    --exclude="/data/shared_home/Downloads/" \
    "${MONTHLY_PATH}"


  # Log completion of monthly backup
  log_message "Monthly backup completed for date: $DATETIME"
fi

# Update the latest link for daily backups
rm -rf "${BACKUP_DIR}/daily/latest"
ln -s "${DAILY_PATH}" "${BACKUP_DIR}/daily/latest"

echo "Backup completed: $DATETIME"
