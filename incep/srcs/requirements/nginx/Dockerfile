FROM debian:bullseye

EXPOSE 443

ARG	CERT_FOLDER=/etc/nginx/certs/
ARG	CERTIFICATE=/etc/nginx/certs/certificate.crt
ARG	KEY=/etc/nginx/certs/certificate.key
ARG	COUNTRY=PT
ARG	STATE=PT
ARG	LOCALITY=Porto
ARG	ORGANIZATION=42
ARG	UNIT=42
ARG	COMMON_NAME=hfilipe-.42.fr

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


