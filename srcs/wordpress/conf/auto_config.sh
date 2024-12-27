#!/bin/bash

WORDPRESS_PATH='/var/www/wordpress'

cd $WORDPRESS_PATH

echo "Waiting for MariaDB connection..."
until mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -h"mariadb" --silent; do
	echo "MariaDB not ready yet. Retrying..."
	sleep 2
done
echo "MariaDB is up and running."

if [ -f ./wp-config.php ]; then
	echo "WordPress is already set up."
else
	wp config create --allow-root \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost="mariadb:3306"

	echo "wp-config.php file created successfully."

	wp core install --allow-root \
		--url="$DOMAIN_NAME" \
		--title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN" \
		--admin_password="$WORDPRESS_ADMIN_PASSWORD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL"

	echo "WordPress installed successfully."

	wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" --role=editor --user_pass="$WORDPRESS_PASSWORD" --allow-root

	echo "Second user created successfully."
fi

if [ ! -d "/run/php" ]; then
	mkdir -p /run/php
	echo "Created /run/php directory."
fi
