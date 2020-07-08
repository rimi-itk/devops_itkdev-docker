FROM itkdev/php7.0-fpm
MAINTAINER ITK dev <itkdev@mkb.aarhus.dk>

ENV DRUSH_VERSION 6.7.0

# Ensure packages are avaiable.
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -y curl \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Drush using Composer.
RUN composer global require drush/drush:"$DRUSH_VERSION" --prefer-dist

# Add registry_rebuild module.
RUN /root/.composer/vendor/bin/drush dl registry_rebuild

# Display which version of Drush was installed
RUN /root/.composer/vendor/bin/drush --version

ENV PATH="/root/.composer/vendor/bin/:${PATH}"

ENTRYPOINT ["drush"]
