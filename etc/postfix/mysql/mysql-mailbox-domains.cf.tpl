user = ${MAIL_DB_ROOT_USERNAME}
password = ${MYSQL_ROOT_PASSWORD}
hosts = ${MAIL_DB_HOST}
dbname = ${MAIL_DB_NAME}
query = SELECT 1 FROM i_domains WHERE name='%s' and active=1