until mysqladmin ping -h"$MARIA_HOSTNAME" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done
echo "MariaDB is up and running..."

if [ -f ./wp-config.php]; then
	echo "WordPress is already set up"
else
	wp config create	--allow-root \
	--dbname=$SQL_DATABASE \
	--dbuser=$SQL_USER \
	--dbpass=$SQL_PASSWORD \
	--dbhost=mariadb:3306 --path='/var/www/wordpress'

wp core install --allow-root \
	--url="$DOMAIN_NAME" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USER" \
	--admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL"

wp user create "$WP_USER" "$WP_USER_EMAIL" --role=editor --user_pass="$WP_USER_PASSWORD" --allow-root

exec php-fpm7.3 -F
