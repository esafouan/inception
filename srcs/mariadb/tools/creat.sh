#!/bin/bash
service mariadb start
sleep 10

mariadb -e "CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON \`$DATABASE_NAME\`.* TO '$MYSQL_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"

service mariadb stop
sleep 2

mysqld_safe --bind-address=0.0.0.0 2>/dev/null
