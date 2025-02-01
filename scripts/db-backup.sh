#!/bin/bash
source .env

# Check required environment variables
if [ -z "$BACKUP_DB_HOST" ] || [ -z "$BACKUP_DB_PORT" ] || [ -z "$BACKUP_DB_USER" ] || [ -z "$BACKUP_DB_NAME" ] || [ -z "$PGPASSWORD" ]; then
    echo "Error: Required environment variables are not set"
    echo "Please ensure BACKUP_DB_HOST, BACKUP_DB_PORT, BACKUP_DB_USER, BACKUP_DB_NAME, and PGPASSWORD are set in .env"
    exit 1
fi

# Create backups directory if it doesn't exist
mkdir -p ./supabase/backups

# Create backup with timestamp
BACKUP_FILE="./supabase/backups/full_backup_$(date +%Y%m%d_%H%M%S).dump"
echo "Creating backup: $BACKUP_FILE"

pg_dump -h "$BACKUP_DB_HOST" \
  -p "$BACKUP_DB_PORT" \
  -U "$BACKUP_DB_USER" \
  -d "$BACKUP_DB_NAME" \
  --clean \
  --if-exists \
  --quote-all-identifiers \
  --format=custom \
  --file="$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully"
else
    echo "Backup failed"
    exit 1
fi 