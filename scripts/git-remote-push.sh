#! /bin/bash

set -eu
set -o pipefail


readonly DATA_DIR=/data
readonly SOURCE_DIR=(
    "data/codebox/gitlab.com/e-store"
    "data/dotfiles"
)
readonly LOG_DIR="/data/logs"
readonly GIT_MESSAGE="💾"
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
readonly LOG_FILE="${LOG_DIR}/git-remote-push.log"

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


for dir in "${SOURCE_DIR[@]}" ; do
    DIR_PATH="${HOME}/${dir}"
    cd "$DIR_PATH"
    log_message "Starting Git add/commit for dir: $dir"
    GIT_STATUS="$(git status --branch --porcelain)"
    git add .
    if [ "$GIT_STATUS" == "## main...origin/main" ]; then
        log_message "Nothing to add/commit for dir: $dir"
    else
        git commit -m"${GIT_MESSAGE}"  >> "$LOG_FILE" 2>&1
        log_message "Git add/commit completed for dir: $dir"
        log_message "Starting remote push for dir: $dir"
        git push origin >> "$LOG_FILE" 2>&1
        log_message "Remote push completed for dir: $dir"
    fi
done
