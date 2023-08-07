FROM alpine:3.17

RUN apk update && apk add --no-cache --quiet --update mariadb mariadb-client

RUN mkdir -p /var/lib/mysqld /run/mysqld

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/
COPY ./scripts/create_db.sql /tmp/create_db.sql
COPY ./scripts/entrypoint.sh ./

RUN chmod +x ./entrypoint.sh \
	&& mariadb-install-db --datadir=/var/lib/mysql \
		--auth-root-authentication-method=normal \
	&& chown -R mysql:mysql /var/lib/mysql \
	&& chown -R mysql:mysql /run/mysqld

ENTRYPOINT [ "sh", "entrypoint.sh" ]
