FROM alpine:3.16
LABEL Maintainer="Afterlogic Support <support@afterlogic.com>" \
      Description="Afterlogic WebMail Lite image for Docker - using Nginx, PHP-FPM 8, MySQL on Alpine Linux"
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.nju.edu.cn/g' /etc/apk/repositories
RUN  apk update && apk upgrade
# 增加用户及用户组，设置权限
RUN set -ex && \
    addgroup -g 5000 vmail && \
    adduser -G vmail -u 5000 -h /var/mail -D vmail
RUN apk --no-cache add php81 \
	php81-cli \
	php81-fpm \
	php81-fileinfo \
	php81-mysqli \
	php81-pdo \
	php81-pdo_mysql \
	php81-pdo_sqlite \
	php81-iconv \
	php81-mbstring \
	php81-curl \
	php81-dom \
	php81-xml \
	php81-gd \
	php81-exif \
	php81-zip \
	php81-xmlwriter \
	php81-xmlreader \
	nginx supervisor curl tzdata mysql-client

RUN  apk --no-cache add postfix postfix-mysql\
     dovecot dovecot-pop3d dovecot-lmtpd dovecot-mysql \
     libsasl cyrus-sasl clamav perl-authen-sasl
RUN apk --no-cache add busybox-extras bash gettext


COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY config/php.ini /etc/php81/conf.d/custom.ini
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


RUN mkdir -p /var/www/html && mkdir mkdir -p /data/mail

WORKDIR /var/www/html

COPY webmail_php.zip /tmp
RUN unzip -qq /tmp/webmail_php.zip -d /var/www/html
COPY config/afterlogic.php /var/www/html/afterlogic.php

RUN php81 /var/www/html/afterlogic.php

COPY etc/postfix /etc/postfix
COPY etc/dovecot /etc/dovecot
COPY etc/ssl /etc/ssl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


EXPOSE 80 25 110 143
#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
CMD ["/entrypoint.sh"]
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1/fpm-ping

# afterlogic
# docker build -t moese/webmail-lite:1.0.0 .
# docker build -t moese/webmail-lite:1.0.0-amd64 .
