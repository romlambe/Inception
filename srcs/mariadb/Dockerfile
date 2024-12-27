FROM debian:bullseye

RUN apt-get update &&\
	apt-get install -y mariadb-server &&\
	chown -R mysql:mysql /var/lib/mysql &&\
	chmod -R 750 /var/lib/mysql

COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh && \
	echo "Check of mariadb.sh" && \
	ls -l /usr/local/bin/mariadb.sh

CMD ["/usr/local/bin/mariadb.sh"]
