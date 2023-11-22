#!/bin/bash
read -p "Enter source path: " SOURCE_PATH
read -p "Enter destination path: " DESTINATION_PATH

while true; do
    # Prompt for source and destination paths

    echo "Choose an option:"
    echo "1. Dry Run"
    echo "2. Proceed with Rsync"
    echo "3. Exit"
    read -p "Enter your choice (1, 2, or 3): " choice

    case $choice in
        1)
            # Dry run
            echo $SOURCE_PATH
            echo $DESTINATION_PATH
            # rsync -av --delete --dry-run "$SOURCE_PATH" "$DESTINATION_PATH"
            ;;
        2)
            # Proceed with restoration
            echo rsync
            # rsync -av --delete "$SOURCE_PATH" "$DESTINATION_PATH"
            echo "Exiting."
            exit 0
            ;;
        3)
            # Exit the loop
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please choose again."
            ;;
    esac
done
