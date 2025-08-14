#!/bin/bash

# Ensure socket directory exists
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

[ -f /run/secrets/db_root_password ] && export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
[ -f /run/secrets/db_user ] && export MYSQL_USER=$(cat /run/secrets/db_user)
[ -f /run/secrets/db_password ] && export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
[ -f /run/secrets/db_name ] && export MYSQL_DATABASE=$(cat /run/secrets/db_name)

# Ensure correct ownership of the data directory
chown -R mysql:mysql /var/lib/mysql

# Initialize database if not already initialized
if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    mysqld --user=mysql --bootstrap <<EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
fi

# Start MariaDB as mysql user
exec gosu mysql "$@"
