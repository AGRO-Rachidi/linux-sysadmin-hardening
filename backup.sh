#!/bin/bash
# backup.sh
# Sauvegarde chiffree avec rotation automatique sur 7 jours.
# testees : cycle complet chiffrement/dechiffrement valide, restauration
# testee avec verification diff -r).

set -e

SOURCE_DIR="/data/comptabilite"
BACKUP_DIR="/mnt/backup"
PASSPHRASE_FILE="/root/.backup_passphrase"
DATE=$(date +"%Y-%m-%d_%H%M%S")
ARCHIVE="$BACKUP_DIR/backup_$DATE.tar.gz"

mkdir -p "$BACKUP_DIR"

tar -czf "$ARCHIVE" -C /data "$(basename "$SOURCE_DIR")"

gpg --batch --yes --passphrase-file "$PASSPHRASE_FILE" \
    --symmetric --cipher-algo AES256 -o "$ARCHIVE.gpg" "$ARCHIVE"

rm -f "$ARCHIVE"   # jamais de version en clair conservee

find "$BACKUP_DIR" -name "*.tar.gz.gpg" -mtime +7 -delete   # rotation 7 jours

echo "Sauvegarde chiffree effectuee le $(date) : $ARCHIVE.gpg"
