#!/bin/bash


echo "初始化postfix"

# postfix替换数据库配置文件
envsubst < /etc/postfix/mysql/mysql-alias-maps.cf.tpl > /etc/postfix/mysql/mysql-alias-maps.cf
envsubst < /etc/postfix/mysql/mysql-mailbox-domains.cf.tpl > /etc/postfix/mysql/mysql-mailbox-domains.cf
envsubst < /etc/postfix/mysql/mysql-mailbox-maps.cf.tpl > /etc/postfix/mysql/mysql-mailbox-maps.cf
envsubst < /etc/postfix/mysql/mysql-sender-login-maps.cf.tpl > /etc/postfix/mysql/mysql-sender-login-maps.cf
envsubst < /etc/postfix/mysql/mysql_bcc_user.cf.tpl > /etc/postfix/mysql/mysql_bcc_user.cf
#envsubst < /etc/postfix/main.cf.tpl > /etc/postfix/main.cf
postconf -e "myhostname = $(hostname -f)"
postconf -e "mydomain = $(hostname -d)"
postconf -e "myorigin = $(hostname -f)"
postconf -e "mynetworks = $(hostname -i)/8"

echo "初始化postfix完成"

echo "初始化dovecot"
# dovecot替换数据库配置文件
envsubst < /etc/dovecot/dovecot-dict-sql.conf.ext.tpl > /etc/dovecot/dovecot-dict-sql.conf.ext
envsubst < /etc/dovecot/dovecot-sql.conf.ext.tpl > /etc/dovecot/dovecot-sql.conf.ext
echo "初始化dovecot完成"

echo "授权邮件目录  vmail:vmail /data/mail"
chown -R vmail:vmail /data/mail
echo "授权邮件目录结束"
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf


