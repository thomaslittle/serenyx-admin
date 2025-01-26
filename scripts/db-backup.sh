#!/bin/bash
source .env

pg_dump -h "$BACKUP_DB_HOST" \
  -p "$BACKUP_DB_PORT" \
  -U "$BACKUP_DB_USER" \
  -d "$BACKUP_DB_NAME" \
  --clean \
  --if-exists \
  --quote-all-identifiers \
  --format=custom \
  --file="./supabase/backups/full_backup_$(date +%Y%m%d_%H%M%S).dump" 