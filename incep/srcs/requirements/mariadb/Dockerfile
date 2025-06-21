FROM debian:bullseye

# Expose MariaDB default port
EXPOSE 3306

# Install MariaDB server and cleanup
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
    mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy MariaDB configuration and setup script
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/setup.sh /bin/

# Make setup.sh executable
RUN chmod +x /bin/setup.sh

# Start MariaDB and run setup script
CMD ["bash", "-c", "service mariadb start && /bin/setup.sh && tail -f /dev/null"]
