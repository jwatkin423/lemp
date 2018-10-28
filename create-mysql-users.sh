#!/usr/bin/env bash

mysql -uroot -p$ROOT_PASSWORD << EOF
CREATE USER 'josephwatkinadmin'@'localhost' IDENTIFIED BY $PR_PASSWORD;
CREATE USER 'josephwatkinadmin_dev'@'localhost' IDENTIFIED BY $DEV_PASSWORD;
CREATE USER 'josephwatkinadmin_qa'@'localhost' IDENTIFIED BY $QA_PASSWORD;
CREATE USER 'josephwatkinadmin_ro'@'localhost' IDENTIFIED BY $RO_PASSWORD;
CREATE USER 'josephwatkinadmin'@'%' IDENTIFIED BY $PR_PASSWORD;
CREATE USER 'josephwatkinadmin_dev'@'%' IDENTIFIED BY $DEV_PASSWORD;
CREATE USER 'josephwatkinadmin_qa'@'%' IDENTIFIED BY $QA_PASSWORD;
CREATE USER 'josephwatkinadmin_ro'@'%' IDENTIFIED BY $RO_PASSWORD;
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
EOF