#!/bin/bash

mkdir /var/www/inception/secrects
cp /run/secrets/* /var/www/inception/secrects

export WP_ADMIN_PASSWORD="$(cat /run/secrets/wp_admin_password)"
export WP_PASSWORD="$(cat /run/secrets/wp_user_password)"
export WP_ADMIN_USER="$(cat /run/secrets/wp_admin)"
export WP_USER="$(cat /var/www/inception/secrects/wp_user)"

mv -f /tmp/wp-config.php "$WP_PATH/"

# Download WordPress core if not already present
if [ ! -f "$WP_PATH/wp-load.php" ]; then
    wp --allow-root --path="$WP_PATH" core download
fi

# Set correct permissions
chown -R www-data:www-data "$WP_PATH"

# Install WordPress if not already installed
if ! wp --allow-root --path="$WP_PATH" core is-installed; then
    wp --allow-root --path="$WP_PATH" core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"
fi

# Create additional user if not already present
if ! wp --allow-root --path="$WP_PATH" user get "$WP_USER" >/dev/null 2>&1; then
    wp --allow-root --path="$WP_PATH" user create \
        "$WP_USER" "$WP_EMAIL" \
        --user_pass="$WP_PASSWORD" \
        --role="$WP_ROLE"
fi

# Install and activate theme
wp --allow-root --path="$WP_PATH" theme install raft --activate

# Hand off to container's CMD
exec "$@"
