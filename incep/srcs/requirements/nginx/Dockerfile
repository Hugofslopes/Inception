# Use the official NGINX image as a base
FROM nginx:latest

# Install OpenSSL to ensure TLSv1.3 support
RUN apt-get update && apt-get install -y openssl

# Copy the custom NGINX configuration file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your SSL certificate and key into the container
COPY ssl/certificate.crt /etc/ssl/certs/
COPY ssl/private.key /etc/ssl/private/

# Expose ports 80 and 443
EXPOSE 80 443
