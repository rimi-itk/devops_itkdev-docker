FROM php:7.2-fpm-alpine
LABEL maintainer="ITK Dev <itkdev@mkb.aarhus.dk>"

ENV PHP_VERSION 7.2

RUN apk add --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        imagemagick \
        imagemagick-libs \
        imagemagick-dev \
        libxml2-dev \
        autoconf \
        g++ \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-install -j$(nproc) json \
    && CFLAGS="-I/usr/src/php" docker-php-ext-install -j$(nproc) xmlreader \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) ctype \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN apk add --update --no-cache --virtual .build-deps autoconf g++ make \
    && pecl install redis-4.0.1 imagick \
    && docker-php-ext-enable redis imagick \
    && apk del .build-deps
