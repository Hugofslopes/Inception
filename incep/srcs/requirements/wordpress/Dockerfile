# Use the official WordPress image with PHP-FPM
FROM wordpress:latest

# Optional: Install additional PHP extensions if needed
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Expose the PHP-FPM port
EXPOSE 9000
