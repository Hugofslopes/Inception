#!/bin/bash

# Read secrets from Docker secrets files
if [ -f /run/secrets/wp_admin_password ]; then
    WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
else
    echo "ERROR: Missing wp_admin_password secret!"
    exit 1
fi

if [ -f /run/secrets/wp_user_password ]; then
    WP_PASSWORD=$(cat /run/secrets/wp_user_password)
else
    echo "ERROR: Missing wp_user_password secret!"
    exit 1
fi

# At this point, WP_PATH, WP_URL, WP_TITLE, WP_ADMIN_USER, etc.
# should already be set as environment variables by Docker from .env or docker-compose

if ! grep -q "wp-settings.php" "$WP_PATH/wp-config.php" 2>/dev/null; then
    mv -f /tmp/wp-config.php "$WP_PATH/"
fi

if [ ! -f "$WP_PATH/wp-load.php" ]; then
    wp --allow-root --path="$WP_PATH" core download
fi

chown -R www-data:www-data "$WP_PATH"

if ! wp --allow-root --path="$WP_PATH" core is-installed; then
    wp --allow-root --path="$WP_PATH" core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"
fi

if ! wp --allow-root --path="$WP_PATH" user get "$WP_USER" >/dev/null 2>&1; then
    wp --allow-root --path="$WP_PATH" user create \
        "$WP_USER" "$WP_EMAIL" \
        --user_pass="$WP_PASSWORD" \
        --role="$WP_ROLE"
fi

wp --allow-root --path="$WP_PATH" theme install raft --activate

exec "$@"
