FROM debian:buster

RUN apt update && apt install -y nginx openssl
RUN mkdir -p /etc/nginx/ssl
RUN	openssl req -x509 -nodes -out /etc/nginx/ssl/romlambe.crt \
	-keyout /etc/nginx/ssl/romlambe.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=romlambe.42.fr/UID=romlambe"

RUN mkdir -p /var/run/nginx

COPY /conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 775 /var/www/html && \
	chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
