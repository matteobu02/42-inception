FROM debian:11

RUN apt-get update && apt-get install -y curl lsb-release ca-certificates apt-transport-https \
	software-properties-common gnupg2 \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
	&& curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
	&& apt-get update && apt-get install -y php8.2 php8.2-common php8.2-mysql php-fpm

RUN mkdir -p /var/www/wordpress /run/php

WORKDIR /var/www/wordpress

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/bin/wp \
	&& chmod +x /usr/bin/wp \
	&& wp core download --allow-root

COPY ./conf/wp-config.php /tmp/wp-config.php
COPY ./scripts/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

ENTRYPOINT ["sh", "/tmp/entrypoint.sh"]
