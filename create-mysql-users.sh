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
CREATE USER 'josephwatkinadmin'@'localhost' IDENTIFIED BY ${PR_PASSWORD};
CREATE USER 'josephwatkinadmin_dev'@'localhost' IDENTIFIED BY ${DEV_PASSWORD};
CREATE USER 'josephwatkinadmin_qa'@'localhost' IDENTIFIED BY ${QA_PASSWORD};
CREATE USER 'josephwatkinadmin_ro'@'localhost' IDENTIFIED BY ${RO_PASSWORD};
CREATE USER 'josephwatkinadmin'@'%' IDENTIFIED BY ${PR_PASSWORD};
CREATE USER 'josephwatkinadmin_dev'@'%' IDENTIFIED BY ${DEV_PASSWORD};
CREATE USER 'josephwatkinadmin_qa'@'%' IDENTIFIED BY ${QA_PASSWORD};
CREATE USER 'josephwatkinadmin_ro'@'%' IDENTIFIED BY ${RO_PASSWORD};
DROP DATABASE IF EXISTS josephwatkin_pr; CREATE DATABASE josephwatkin_pr CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON josephwatkin_pr.* TO 'josephwatkinadmin'@'localhost';
GRANT ALL ON josephwatkin_pr.* TO 'josephwatkinadmin'@'%';
DROP DATABASE IF EXISTS josephwatkin_dev; CREATE DATABASE josephwatkin_dev CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON josephwatkin_dev.* TO 'josephwatkinadmin'@'localhost';
GRANT ALL ON josephwatkin_dev.* TO 'josephwatkinadmin'@'%';
GRANT ALL ON josephwatkin_dev.* TO 'josephwatkinadmin_dev'@'localhost';
GRANT ALL ON josephwatkin_dev.* TO 'josephwatkinadmin_dev'@'%';
GRANT SELECT, SHOW VIEW ON josephwatkin_dev.* TO 'josephwatkinadmin_ro'@'localhost';
GRANT SELECT, SHOW VIEW ON josephwatkin_dev.* TO 'josephwatkinadmin_ro'@'%';
DROP DATABASE IF EXISTS josephwatkin_qa; CREATE DATABASE josephwatkin_qa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON josephwatkin_qa.* TO 'josephwatkinadmin'@'localhost';
GRANT ALL ON josephwatkin_qa.* TO 'josephwatkinadmin'@'%';
GRANT ALL ON josephwatkin_qa.* TO 'josephwatkinadmin_dev'@'localhost';
GRANT ALL ON josephwatkin_qa.* TO 'josephwatkinadmin_dev'@'%';
GRANT SELECT, SHOW VIEW ON josephwatkin_qa.* TO 'josephwatkinadmin_ro'@'localhost';
GRANT SELECT, SHOW VIEW ON josephwatkin_qa.* TO 'josephwatkinadmin_ro'@'%';
FLUSH privileges;
_EOF_

echo "Done User Set up"