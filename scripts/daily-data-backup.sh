#! /bin/bash

set -eu
set -o pipefail

readonly SOURCE_DIR="/data"
readonly BACKUP_DIR="/backup"
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
readonly LOG_DIR="/data/logs"
readonly HOMEMANAGER_DIR="${HOME}/.config/home-manager"
readonly DOFILES_DIR="/data/dotfiles"
readonly EXTENSIONS_DIR="${HOME}/.local/share/gnome-shell/extensions"
readonly EXTENSIONS_DUPE_DIR="/data/extensions"
readonly LOG_FILE="${LOG_DIR}/daily-data-backup.log"

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
log_message "Starting backup for date: $DATETIME"

log_message "Backup home-manager"
rsync -av --delete --ignore-existing "$HOMEMANAGER_DIR/" "$DOFILES_DIR/home-manager/"

log_message "Backup from home to data dir"

yq=/home/percygt/.nix-profile/bin/yq
# Check if yq is installed
if ! command -v $yq &> /dev/null; then
    echo "yq is not installed. Please install it before running this script."
    exit 1
fi
config="/data/rsync_home/config.yaml"
# Read YAML using yq
root_data_dir=$($yq -r '.root_data_dir' $config)
root_home_dir=$($yq -r '.root_home_dir' $config)

# Loop through items and perform rsync
items=$($yq -c '.items[]' $config)
while IFS= read -r items; do
    data_dir=$(echo "$items" | $yq -r '.data_dir')
    home_dir=$(echo "$items" | $yq -r '.home_dir')
    skip_backup=$(echo "$items" | $yq -r '.skip_backup // 0' -)

    # Skip backup if skip_backup is set to 1
    if [ "$skip_backup" -eq 1 ]; then
        echo "Skipping backup for $home_dir (skip_backup is set to 1)"
        continue
    fi
    echo "from $home_dir to $data_dir"
    # Run rsync command
    rsync -av --delete \
    --exclude-from=<(find $root_data_dir/$data_dir -type l -exec sh -c 'readlink -f "$0" | grep -q "/nix" && echo "$0"' {} \;) \
    "$root_home_dir/$home_dir/" "$root_data_dir/$data_dir/"

done <<< "$items"


# Log start of backup
log_message "Backup from data to backup dir"
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
