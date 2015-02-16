FROM buildpack-deps:wheezy-scm

MAINTAINER Martin Miklós <miklos.martin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# install php
ADD dotdeb.list /etc/apt/sources.list.d/dotdeb.list
RUN wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -
RUN apt-get update && \
    apt-get install -y php5-cli \
        php5-curl php5-gd php5-geoip php5-imagick php5-imap php5-intl \
        php5-mcrypt php5-memcache php5-memcached php5-redis \
        php5-mysql php5-pgsql php5-sqlite php5-apcu php5-xdebug

# and composer
RUN wget -O- https://getcomposer.org/installer | php -- --filename=composer --install-dir=/bin

# custom ini
ADD php.ini /etc/php5/mods-available/custom.ini
RUN ln -s /etc/php5/mods-available/custom.ini /etc/php5/cli/conf.d/99-cus
