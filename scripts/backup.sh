#!/bin/bash

# CONSTRUCTIQ Backup Script
# Backs up database and uploaded files

set -e

# Configuration
BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DB_BACKUP_FILE="$BACKUP_DIR/db_backup_$TIMESTAMP.sql"
FILES_BACKUP_FILE="$BACKUP_DIR/files_backup_$TIMESTAMP.tar.gz"

# Colors
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Starting backup...${NC}"

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup database
echo "Backing up database..."
docker-compose exec -T postgres pg_dump -U constructiq constructiq > $DB_BACKUP_FILE
gzip $DB_BACKUP_FILE

# Backup uploaded files
echo "Backing up uploaded files..."
tar -czf $FILES_BACKUP_FILE \
    backend-api/storage/app/public \
    ai-engine/uploads 2>/dev/null || true

# Remove old backups (keep last 7 days)
find $BACKUP_DIR -name "*.gz" -mtime +7 -delete

echo -e "${GREEN}Backup complete!${NC}"
echo "Database backup: ${DB_BACKUP_FILE}.gz"
echo "Files backup: $FILES_BACKUP_FILE"

