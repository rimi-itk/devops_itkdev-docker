FROM ubuntu:20.04
LABEL maintainer "ITK Dev <itkdev@mkb.aarhus.dk>"

ENV PHP_VERSION 8.1

# Ensure packages are avaiable.
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    apt-utils \
    iputils-ping

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y language-pack-en-base \
    software-properties-common \
&& locale-gen en_US.UTF-8

# Add php repositories
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php \
&& apt-get update

# Clean up
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get remove -y software-properties-common language-pack-en-base \
&& apt-get autoremove -y

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-readline \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-xsl \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-xdebug \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-amqp \
    php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-memcached \
    php${PHP_VERSION}-mongodb \
    php${PHP_VERSION}-apcu \
    php${PHP_VERSION}-redis \
    php-pear \
    libmcrypt-dev \
    libreadline-dev \
    mysql-client \
    unzip \
    git \
    imagemagick \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY etc/ /etc/

# Install composer (both composer version as set symlink to right version in entry-point)
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer1
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer2

# Set default composer version (can be overriden in entry-point via COMPOSER_VERSION env)
RUN ln -fs /usr/bin/composer1 /usr/local/bin/composer

# Add mhsendmail for mailhog
ADD https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
RUN chmod +x /usr/local/bin/mhsendmail

# Install configuration template handler
ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

EXPOSE 9000

WORKDIR /app

COPY docker-entrypoint.sh /usr/local/bin/
CMD [ "docker-entrypoint.sh" ]
