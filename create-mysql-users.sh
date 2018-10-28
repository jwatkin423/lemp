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
DROP DATABASE IF EXISTS josephwatkin_pr; CREATE DATABASE josephwatkin_pr CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON josephwatkin_pr.* TO 'jwadmin'@'localhost';
GRANT ALL ON josephwatkin_pr.* TO 'jwadmin'@'%';
DROP DATABASE IF EXISTS josephwatkin_dev; CREATE DATABASE josephwatkin_dev CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON josephwatkin_dev.* TO 'jwadmin'@'localhost';
GRANT ALL ON josephwatkin_dev.* TO 'jwadmin'@'%';
GRANT ALL ON josephwatkin_dev.* TO 'jwadmin_dev'@'localhost';
GRANT ALL ON josephwatkin_dev.* TO 'jwadmin_dev'@'%';
GRANT SELECT, SHOW VIEW ON josephwatkin_dev.* TO 'jwadmin_ro'@'localhost';
GRANT SELECT, SHOW VIEW ON josephwatkin_dev.* TO 'jwadmin_ro'@'%';
DROP DATABASE IF EXISTS josephwatkin_qa; CREATE DATABASE josephwatkin_qa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON josephwatkin_qa.* TO 'jwadmin'@'localhost';
GRANT ALL ON josephwatkin_qa.* TO 'jwadmin'@'%';
GRANT ALL ON josephwatkin_qa.* TO 'jwadmin_dev'@'localhost';
GRANT ALL ON josephwatkin_qa.* TO 'jwadmin_dev'@'%';
GRANT SELECT, SHOW VIEW ON josephwatkin_qa.* TO 'jwadmin_ro'@'localhost';
GRANT SELECT, SHOW VIEW ON josephwatkin_qa.* TO 'jwadmin_ro'@'%';
FLUSH privileges;
_EOF_

echo "Done User Set up"