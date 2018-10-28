ROOTPWD=generaladmin

# evl "cat ${ROOTDIR}/mysql/create-db-and-users.sql | mysql -u root -p${ROOTPWD}"

cat create-mysql-users.sql | mysql -u root -p$ROOTPWD
cat wiki-mysql.sql | mysql -u root -p$ROOTPWD