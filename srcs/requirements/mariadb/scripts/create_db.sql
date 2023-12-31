CREATE DATABASE $MARIADB_NAME;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO $MARIADB_USER@'%';
FLUSH PRIVILEGES;

SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_ROOT_PASSWORD');
