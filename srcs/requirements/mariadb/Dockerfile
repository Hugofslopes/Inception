FROM debian:bullseye

EXPOSE 3306

RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
    mariadb-server gosu && \
    rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

# Use setup.sh as entrypoint
ENTRYPOINT ["/setup.sh"]
CMD ["mysqld"]
