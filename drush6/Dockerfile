
FROM drush/drush:base
MAINTAINER ITK dev <itkdev@mkb.aarhus.dk>

# Set the Drush version.
ENV DRUSH_VERSION 6.7.0

# Add the memache PHP module.
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y libz-dev libmemcached-dev
RUN pecl install memcached
RUN echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Drush using Composer.
RUN composer global require drush/drush:"$DRUSH_VERSION" --prefer-dist

# Display which version of Drush was installed
RUN drush --version