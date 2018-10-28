CREATE USER 'hit4heroes'@'localhost' IDENTIFIED BY 'QFrYUp5zXEsd3Wa5';
CREATE USER 'hit4heroes'@'%' IDENTIFIED BY 'QFrYUp5zXEsd3Wa5';

CREATE USER 'hit4heroes_dev'@'localhost' IDENTIFIED BY 'hit4heroes.dev';
CREATE USER 'hit4heroes_dev'@'%' IDENTIFIED BY 'hit4heroes.dev';

CREATE USER 'hit4heroes_ro'@'localhost' IDENTIFIED BY 'hit4heroes.ro';
CREATE USER 'hit4heroes_ro'@'%' IDENTIFIED BY 'hit4heroes.ro';

DROP DATABASE IF EXISTS hit4heroes_pr; CREATE DATABASE hit4heroes_pr CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON hit4heroes_pr.* TO 'hit4heroes'@'localhost';
GRANT ALL ON hit4heroes_pr.* TO 'hit4heroes'@'%';

DROP DATABASE IF EXISTS hit4heroes_dev; CREATE DATABASE hit4heroes_dev CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON hit4heroes_dev.* TO 'hit4heroes'@'localhost';
GRANT ALL ON hit4heroes_dev.* TO 'hit4heroes'@'%';
GRANT ALL ON hit4heroes_dev.* TO 'hit4heroes_dev'@'localhost';
GRANT ALL ON hit4heroes_dev.* TO 'hit4heroes_dev'@'%';
GRANT SELECT, SHOW VIEW ON hit4heroes_dev.* TO 'hit4heroes_ro'@'localhost';
GRANT SELECT, SHOW VIEW ON hit4heroes_dev.* TO 'hit4heroes_ro'@'%';

DROP DATABASE IF EXISTS hit4heroes_qa; CREATE DATABASE hit4heroes_qa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL ON hit4heroes_qa.* TO 'hit4heroes'@'localhost';
GRANT ALL ON hit4heroes_qa.* TO 'hit4heroes'@'%';
GRANT ALL ON hit4heroes_qa.* TO 'hit4heroes_dev'@'localhost';
GRANT ALL ON hit4heroes_qa.* TO 'hit4heroes_dev'@'%';
GRANT SELECT, SHOW VIEW ON hit4heroes_qa.* TO 'hit4heroes_ro'@'localhost';
GRANT SELECT, SHOW VIEW ON hit4heroes_qa.* TO 'hit4heroes_ro'@'%';

FLUSH privileges;
