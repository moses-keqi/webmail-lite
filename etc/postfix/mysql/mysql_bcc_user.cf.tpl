user = ${MAIL_DB_ROOT_USERNAME}
password = ${MYSQL_ROOT_PASSWORD}
hosts = ${MAIL_DB_HOST}
dbname = ${MAIL_DB_NAME}
query = SELECT to_email FROM i_bcc_user WHERE source='%s'