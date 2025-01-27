FROM debian:bullseye

RUN apt update && \
    apt install -y nginx vim openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/romlambe.crt \
        -keyout /etc/nginx/ssl/romlambe.key \
        -subj "/C=FR/ST=Paris/L=Paris/O=42PerpignanSchool/OU=student/CN=romlambe/"

RUN mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]