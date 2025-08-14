FROM debian:bullseye

EXPOSE 443

ARG CERT_FOLDER
ARG CERTIFICATE
ARG KEY
ARG COUNTRY
ARG STATE
ARG LOCALITY
ARG ORGANIZATION
ARG UNIT
ARG COMMON_NAME

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN	mkdir -p ${CERT_FOLDER} && \
	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out ${CERTIFICATE} \
	-keyout ${KEY} \
	-subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${COMMON_NAME}"

COPY	conf/nginx.conf	/etc/nginx/
COPY	conf/server.conf /etc/nginx/conf.d/

RUN	mkdir -p /var/www/
RUN	chown -R www-data:www-data /var/www/

CMD	["nginx", "-g", "daemon off;"]