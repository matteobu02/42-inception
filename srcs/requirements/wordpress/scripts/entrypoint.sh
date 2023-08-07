fpm_conf="/etc/php/8.2/fpm/pool.d/www.conf"

grep -E "listen = 127.0.0.1" $fpm_conf > /dev/null 2>&1
if [ $? -eq 0 ]
then
	sed -i "s|.*listen = 127.0.0.1.*|listen = 9000|g" $fpm_conf
	echo "env[MARIADB_HOST] = \$MARIADB_HOST" >> $fpm_conf
	echo "env[MARIADB_NAME] = \$MARIADB_NAME" >> $fpm_conf
	echo "env[MARIADB_USER] = \$MARIADB_USER" >> $fpm_conf
	echo "env[MARIADB_PASSWORD] = \$MARIADB_PASSWORD" >> $fpm_conf
fi

if [ ! -f "wp-config.php" ]
then
	cp /tmp/wp-config.php ./wp-config.php

	sleep 10 

	wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root

	wp plugin update --all --allow-root

	wp user create $WP_DUMMY_USER $WP_DUMMY_EMAIL --role=author --user_pass=$WP_DUMMY_PASSWORD --allow-root
fi

php-fpm8.2 --nodaemonize
