# This file is commonly accessed via dict {} section in dovecot.conf

connect = host=${MAIL_DB_HOST} dbname=${MAIL_DB_NAME} user=${MAIL_DB_ROOT_USERNAME} password=${MYSQL_ROOT_PASSWORD}

# CREATE TABLE quota (
#   username varchar(100) not null,
#   bytes bigint not null default 0,
#   messages integer not null default 0,
#   primary key (username)
# );

map {
  pattern = priv/quota/storage
  table = i_quota
  username_field = email
  value_field = bytes
}
map {
  pattern = priv/quota/messages
  table = i_quota
  username_field = email
  value_field = messages
}

# CREATE TABLE expires (
#   username varchar(100) not null,
#   mailbox varchar(255) not null,
#   expire_stamp integer not null,
#   primary key (username, mailbox)
# );
#
#map {
#  pattern = shared/expire/$user/$mailbox
#  table = expires
#  value_field = expire_stamp
#
#  fields {
#    username = $user
#    mailbox = $mailbox
#  }
#}
