FROM php:8.1.0-fpm-alpine
LABEL maintainer="ITK Dev <itkdev@mkb.aarhus.dk>"

ENV PHP_OPCACHE_ENABLED="1" \
    PHP_OPCACHE_VALIDATE_TIMESTAMPS="1" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="20000" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="64" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10" \
    PHP_APCU_MEMORY_SIZE="16M" \
    PHP_MAX_EXECUTION_TIME="30" \
    PHP_MEMORY_LIMIT="128M" \
    PHP_POST_MAX_SIZE="8M" \
    PHP_UPLOAD_MAX_FILESIZE="2M" \
    PHP_TIMEZONE="Europe/Copenhagen" \
    PHP_PM_TYPE="dynamic" \
    PHP_PM_MAX_CHILDREN="40" \
    PHP_PM_MAX_REQUESTS="0" \
    PHP_PM_START_SERVERS="5" \
    PHP_PM_MIN_SPARE_SERVERS="5" \
    PHP_PM_MAX_SPARE_SERVERS="8" \
    PHP_REQUEST_SLOWLOG_TIMEOUT="0" \
    PHP_SLOWLOG="/var/log/php-slow.log" \
    PHP_USER="deploy" \
    PHP_GROUP="deploy" \
    TZ=Europe/Copenhagen

RUN apk --update add --no-cache \
        libxslt-dev \
        libzip-dev \
        libpng-dev \
        gettext-dev \
        git \
        unzip \
        icu-dev \
        openldap-dev \
        libmcrypt-dev \
        mysql-client \
        libmemcached-libs \
        zlib \
        patch \
        tzdata \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        gd \
        gettext \
        intl \
        ldap \
        pdo_mysql \
        mysqli \
        opcache \
        pdo_mysql \
        sysvsem \
        soap \
        xsl \
        zip

RUN apk --update add --no-cache --virtual .build-deps autoconf g++ make zlib-dev libmemcached-dev cyrus-sasl-dev \
    && pecl install redis \
    && pecl install memcached \
    && docker-php-ext-enable redis memcached \
    && apk del .build-deps

# Install composer (both composer version as set symlink to right version in entry-point)
COPY --from=composer:1 /usr/bin/composer /usr/bin/composer1
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer2

# Set default composer version (can be overriden in entry-point via COMPOSER_VERSION env)
RUN ln -fs /usr/bin/composer1 /usr/local/bin/composer

# Added cache tool.
ADD https://gordalina.github.io/cachetool/downloads/cachetool.phar /usr/local/bin/cachetool
RUN chmod +x /usr/local/bin/cachetool

# Use default PHP production configuration.
RUN mv ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini

# Copy custom PHP configuration.
COPY etc/php/conf.d/opcache.ini ${PHP_INI_DIR}/conf.d/20-opcache.ini
COPY etc/php/conf.d/php.ini ${PHP_INI_DIR}/conf.d/20-php.ini

# Custom FPM configuration.
COPY etc/php-fpm.d/fpm.ini ${PHP_INI_DIR}/../php-fpm.d/zz-fpm-docker.conf

# Add mhsendmail for mailhog
ADD https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
RUN chmod +x /usr/local/bin/mhsendmail

# Add deploy use to match server.
RUN addgroup -g 1001 deploy \
&& adduser -G deploy -u 1001 -H deploy -D

EXPOSE 9000

WORKDIR /app

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD [ "docker-entrypoint.sh" ]

