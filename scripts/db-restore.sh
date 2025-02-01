#!/bin/bash
source .env

# Check required environment variables
if [ -z "$BACKUP_DB_HOST" ] || [ -z "$BACKUP_DB_PORT" ] || [ -z "$BACKUP_DB_USER" ] || [ -z "$BACKUP_DB_NAME" ] || [ -z "$PGPASSWORD" ]; then
    echo "Error: Required environment variables are not set"
    echo "Please ensure BACKUP_DB_HOST, BACKUP_DB_PORT, BACKUP_DB_USER, BACKUP_DB_NAME, and PGPASSWORD are set in .env"
    exit 1
fi

echo -e "\033[1;31m⚠️  WARNING: This will COMPLETELY OVERWRITE the database!\033[0m"
read -p $'\033[1;31mAre you sure you want to proceed? (type YES in caps): \033[0m' confirm

if [ "$confirm" != "YES" ]; then
    echo "Aborting."
    exit 1
fi

# List available backups
echo -e "\nAvailable backups:"
ls -1 ./supabase/backups/

read -p $'\033[1;31mType the backup file name to restore: \033[0m' file

if [ ! -f "./supabase/backups/$file" ]; then
    echo "Error: File not found"
    exit 1
fi

echo -e "\033[1;31mRestoring from ./supabase/backups/$file...\033[0m"

pg_restore -h "$BACKUP_DB_HOST" \
  -p "$BACKUP_DB_PORT" \
  -U "$BACKUP_DB_USER" \
  -d "$BACKUP_DB_NAME" \
  --clean \
  --if-exists \
  --no-owner \
  --no-privileges \
  "./supabase/backups/$file"

if [ $? -eq 0 ]; then
    echo "Restore completed successfully"
else
    echo "Restore failed"
    exit 1
fi 