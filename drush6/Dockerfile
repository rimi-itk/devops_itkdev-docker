
FROM itkdev/php5.6-fpm
MAINTAINER ITK dev <itkdev@mkb.aarhus.dk>

ENV DRUSH_VERSION 6.7.0
ENV PHP_VERSION 5.6

# Ensure packages are avaiable.
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -y curl

# Install Drush using Composer.
RUN composer global require drush/drush:"$DRUSH_VERSION" --prefer-dist

# Display which version of Drush was installed
RUN /root/.composer/vendor/bin/drush --version

ENV PATH="/root/.composer/vendor/bin/:${PATH}"

ENTRYPOINT ["drush"]