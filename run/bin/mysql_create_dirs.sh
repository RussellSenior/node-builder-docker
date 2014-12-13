#/bin/bash

# http://txt.fliglio.com/2013/11/creating-a-mysql-docker-container/
if [ ! -f /var/lib/mysql/ibdata1 ]; then

    /usr/bin/mysql_install_db

    chown -R mysql:mysql /var/lib/mysql
    chmod -R 660 /var/lib/mysql
    chmod -R 770 `find /var/lib/mysql -type d `
    chmod g+rwxs /var/lib/mysql

    # seems odd, but we have to run mysql_install_db twice, once before to get dirs created, 
    # and then afterwards to create the files
    /usr/bin/mysql_install_db

    /usr/bin/mysqld_safe &
    sleep 5s

    mysql -u root < /opt/bin/configure_mysql.sql

    killall mysqld
    sleep 5s

fi

