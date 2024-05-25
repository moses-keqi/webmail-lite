driver = mysql

connect = host=${MAIL_DB_HOST} dbname=${MAIL_DB_NAME} user=${MAIL_DB_ROOT_USERNAME} password=${MYSQL_ROOT_PASSWORD}


default_pass_scheme = MD5
#default_pass_scheme = CRYPT

user_query = \
  SELECT maildir AS home \
  FROM i_users WHERE email='%u'
  
# Query to get a list of all usernames.
iterate_query = SELECT email AS user FROM i_users

password_query = SELECT u.password FROM i_users as u INNER JOIN i_domains as d ON u.domain_id=d.id WHERE u.email='%u' and u.active=1 and d.active=1;
