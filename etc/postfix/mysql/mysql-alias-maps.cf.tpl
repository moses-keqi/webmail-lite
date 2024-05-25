user = ${MAIL_DB_ROOT_USERNAME}
password = ${MYSQL_ROOT_PASSWORD}
hosts = ${MAIL_DB_HOST}
dbname = ${MAIL_DB_NAME}
query = SELECT destination FROM i_aliases WHERE source='%s'