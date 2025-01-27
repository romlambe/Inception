#!/bin/bash

mysqld_safe &

echo "Waiting for MariaDB..."
until mysqladmin ping --silent; do
    sleep 1
done
echo "MariaDB is ready."

mysql -u root -p"${MDB_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MDB_ROOT_PASSWORD}';"

mysql -u root -p"${MDB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MDB_DATABASE}\`;"

mysql -u root -p"${MDB_ROOT_PASSWORD}" -e "ALTER USER 'root'@'%' IDENTIFIED BY '${MDB_ROOT_PASSWORD}';"

mysql -u root -p"${MDB_ROOT_PASSWORD}" -e "GRANT ALL ON ${MDB_DATABASE}.* TO '${MDB_USER}'@'%' IDENTIFIED BY '${MDB_PASSWORD}'; FLUSH PRIVILEGES;"

mysql -u root -p"${MDB_ROOT_PASSWORD}" -e "GRANT ALL ON ${MDB_DATABASE}.* TO 'root'@'%' IDENTIFIED BY '${MDB_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

mysql -u root -p"${MDB_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p"${MDB_ROOT_PASSWORD}" shutdown

exec mysqld_safe