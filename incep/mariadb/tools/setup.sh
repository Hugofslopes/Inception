#!/bin/bash

# Hardcoded values for database setup
DB_NAME="INCEPDATA"
DB_USER="hfilipe-"
DB_PASSWORD="PASS"
DB_PASS_ROOT="PASS"

echo "Waiting for MariaDB to start..."
until mysqladmin ping --silent; do
    sleep 1
done
# MariaDB is now ready, perform the setup
echo "Running database setup..."

# Run SQL commands
mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS_ROOT';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');
EOF

if [ $? -eq 0 ]; then
    echo "Database setup completed successfully."
else
    echo "Database setup failed!"
    exit 1
fi

echo "MariaDB is already running."
tail -f /dev/null