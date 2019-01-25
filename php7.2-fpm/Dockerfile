FROM ubuntu:18.04
LABEL maintainer "ITK Dev <itkdev@mkb.aarhus.dk>"

ENV PHP_VERSION 7.2

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-readline \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-xsl \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-dev \
    php-memcached \
    php-pear \
    libmcrypt-dev \
    libreadline-dev \
    mysql-client \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/php/
COPY etc/ /etc/

# Configure php
RUN pecl install mcrypt-1.0.2
RUN echo extension=mcrypt.so >> /etc/php/${PHP_VERSION}/fpm/php.ini
RUN sed -i '/memory_limit = 128M/c memory_limit = 256M' /etc/php/${PHP_VERSION}/fpm/php.ini \
&& sed -i '/;date.timezone =/c date.timezone = Europe\/Copenhagen' /etc/php/${PHP_VERSION}/fpm/php.ini \
&& sed -i '/upload_max_filesize = 2M/c upload_max_filesize = 16M' /etc/php/${PHP_VERSION}/fpm/php.ini \
&& sed -i '/post_max_size = 8M/c post_max_size = 20M' /etc/php/${PHP_VERSION}/fpm/php.ini

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

EXPOSE 9000

WORKDIR /app

CMD [ "php-fpm7.2", "-F", "--pid", "/var/run/php/php-fpm7.2.pid", "-y", "/etc/php/7.2/fpm/php-fpm.conf" ]