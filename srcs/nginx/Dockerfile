FROM debian:bullseye

RUN apt update && \
	apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365\
	-newkey rsa:4096\
	-keyout /etc/nginx/ssl/romlambe.key\
	-out /etc/nginx/ssl/romlambe.ctr\
	-subj "/C=FR/ST=Paris/L=Paris/O=42PerpignanSchool/OU=student/CN=romlambe/"

RUN mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 775 /var/www/html && \
	chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
