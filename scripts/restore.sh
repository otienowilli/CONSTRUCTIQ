#!/bin/bash

# CONSTRUCTIQ Restore Script
# Restores database and files from backup

set -e

# Check arguments
if [ -z "$1" ]; then
    echo "Usage: ./restore.sh <backup_timestamp>"
    echo "Example: ./restore.sh 20240207_120000"
    exit 1
fi

TIMESTAMP=$1
BACKUP_DIR="./backups"
DB_BACKUP_FILE="$BACKUP_DIR/db_backup_$TIMESTAMP.sql.gz"
FILES_BACKUP_FILE="$BACKUP_DIR/files_backup_$TIMESTAMP.tar.gz"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Check if backup files exist
if [ ! -f "$DB_BACKUP_FILE" ]; then
    echo -e "${RED}Database backup not found: $DB_BACKUP_FILE${NC}"
    exit 1
fi

echo -e "${GREEN}Starting restore...${NC}"

# Restore database
echo "Restoring database..."
gunzip -c $DB_BACKUP_FILE | docker-compose exec -T postgres psql -U constructiq constructiq

# Restore files if backup exists
if [ -f "$FILES_BACKUP_FILE" ]; then
    echo "Restoring files..."
    tar -xzf $FILES_BACKUP_FILE
else
    echo "Files backup not found, skipping..."
fi

echo -e "${GREEN}Restore complete!${NC}"

