#!/usr/bin/env bash

echo "Root User set up ... "
mysql --user=root <<_EOF_
UPDATE mysql.user SET Password=PASSWORD('${ROOT_PASSWORD}') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
_EOF_
echo "Done Root User Set up"

echo "Users set up ... "
mysql -uroot -p${ROOT_PASSWORD} <<_EOF_
CREATE USER 'jwadmin'@'localhost' IDENTIFIED BY ${PR_PASSWORD};
CREATE USER 'jwadmin_dev'@'localhost' IDENTIFIED BY ${DEV_PASSWORD};
CREATE USER 'jwadmin_qa'@'localhost' IDENTIFIED BY ${QA_PASSWORD};
CREATE USER 'jwadmin_ro'@'localhost' IDENTIFIED BY ${RO_PASSWORD};
CREATE USER 'jwadmin'@'%' IDENTIFIED BY ${PR_PASSWORD};
CREATE USER 'jwadmin_dev'@'%' IDENTIFIED BY ${DEV_PASSWORD};
CREATE USER 'jwadmin_qa'@'%' IDENTIFIED BY ${QA_PASSWORD};
CREATE USER 'jwadmin_ro'@'%' IDENTIFIED BY ${RO_PASSWORD};
FLUSH privileges;
_EOF_

echo "Done User Set up"