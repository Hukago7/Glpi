#!/bin/bash

set -e

DB_HOST=${GLPI_DB_HOST:-db}

echo "Attente de MySQL..."
for i in {1..60}; do
    nc -z $DB_HOST 3306 && break
    sleep 1
done

echo "Attente de Redis..."
for i in {1..30}; do
    nc -z redis 6379 && break
    sleep 1
done

echo "Permissions..."
chown -R www-data:www-data /var/www/html/files /var/www/html/config
chmod 755 /var/www/html/files
chmod 775 /var/www/html/config

exec apache2-foreground