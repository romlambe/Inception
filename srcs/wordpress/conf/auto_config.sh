#!/bin/bash

WORDPRESS_PATH='/var/www/wordpress'

cd $WORDPRESS_PATH

echo "Waiting for MariaDB connection..."
until mysql -u root -p"${MDB_ROOT_PASSWORD}" -h"mariadb" --silent; do
    sleep 2
done
echo "MariaDB is up and running."

# Check if wp-config.php already exists
if [ -f ./wp-config.php ]; then
    echo "WordPress is already set up."
else
    wp config create --allow-root \
        --dbname="$MDB_DATABASE" \
        --dbuser="$MDB_USER" \
        --dbpass="$MDB_PASSWORD" \
        --dbhost="mariadb:3306"
    
    echo "wp-config.php file created successfully."

    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    echo "WordPress installed successfully."

    wp user create "$WP_USER" "$WP_USER_EMAIL" --role=editor --user_pass="$WP_USER_PASSWORD" --allow-root

    echo "Second user created successfully."
fi

if [ ! -d "/run/php" ]; then
    mkdir -p /run/php
    echo "Created /run/php directory."
fi