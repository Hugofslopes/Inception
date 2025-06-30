#!/bin/bash

# Load secrets or environment variables
DB_PASSWORD="$(cat run/secrets/db_password)"
DB_PASS_ROOT="$(cat run/secrets/db_root_password)"

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
    sleep 1
done

# Run SQL setup
mysql -u root -p"$DB_PASS_ROOT" <<EOF
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS_ROOT';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');
FLUSH PRIVILEGES;
EOF

# Check result
if [ $? -eq 0 ]; then
    echo "✅ Database setup completed successfully."
else
    echo "❌ Database setup failed!"
    exit 1
fi
