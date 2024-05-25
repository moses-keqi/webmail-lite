user = ${MAIL_DB_ROOT_USERNAME}
password = ${MYSQL_ROOT_PASSWORD}
hosts = ${MAIL_DB_HOST}
dbname = ${MAIL_DB_NAME}
query = SELECT email FROM i_users WHERE email='%s' and active=1