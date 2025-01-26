#!/bin/bash
source .env

echo -e "\033[1;31m⚠️  WARNING: This will COMPLETELY OVERWRITE the database!\033[0m"
read -p $'\033[1;31mAre you sure you want to proceed? (type YES in caps): \033[0m' confirm

if [ "$confirm" != "YES" ]; then
    echo "Aborting."
    exit 1
fi

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