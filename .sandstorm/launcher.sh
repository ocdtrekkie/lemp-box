#!/bin/bash

set -euo pipefail

wait_for() {
    local service=$1
    local file=$2
    while [ ! -e "$file" ] ; do
        echo "waiting for $service to be available at $file."
        sleep .1
    done
	
}

# Create a bunch of folders under the clean /var that php, nginx, and mysql expect to exist
mkdir -p /var/lib/mysql-files
mkdir -p /var/lib/nginx
mkdir -p /var/lib/php/sessions
mkdir -p /var/log
mkdir -p /var/log/mysql
mkdir -p /var/log/nginx
# Wipe /var/run, since pidfiles and socket files from previous launches should go away
# TODO someday: I'd prefer a tmpfs for these.
rm -rf /var/run
mkdir -p /var/run/php
rm -rf /var/tmp
mkdir -p /var/tmp
mkdir -p /var/run/mysqld

# LEMP box probably expects these to exist already, but we'll make them anyways
if [ ! -e /var/www/index.php ]; then
    echo "staging www folder"
    mkdir -p /var/www
	echo "Hello world" > /var/www/index.php
fi
if [ ! -e /var/sql ]; then
    echo "staging sql import folder"
    mkdir -p /var/sql
fi

# Ensure mysql tables created
if [ ! -e /var/lib/mysql ]; then
    mkdir -p /var/lib/mysql
	HOME=/etc/mysql /usr/sbin/mysqld --initialize
fi

# Spawn mysqld, php
HOME=/etc/mysql /usr/sbin/mysqld --skip-grant-tables &
/usr/sbin/php-fpm7.4 --nodaemonize --fpm-config /etc/php/7.4/fpm/php-fpm.conf &
# Wait until mysql and php have bound their sockets, indicating readiness
wait_for mysql /var/run/mysqld/mysqld.sock

# run SQL file if it exists
if [ -e /var/sql/import.sql ]; then
    echo "importing sql"
    mysql --user "root" -e "CREATE DATABASE app"
    mysql --user "root" --database "app" < /var/sql/import.sql
	rm -f /var/sql/import.sql
fi

wait_for php-fpm7.4 /var/run/php/php7.4-fpm.sock

# Start nginx.
/usr/sbin/nginx -c /opt/app/.sandstorm/service-config/nginx.conf -g "daemon off;"
