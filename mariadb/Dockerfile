FROM mariadb:10.3
MAINTAINER ITK dev <itkdev@mkb.aarhus.dk>

# Ensure packages are avaiable.
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    openssl \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy configuration
COPY etc/confd /etc/confd
COPY docker.cnf /etc/mysql/conf.d/docker.cnf

# Genrate encryption keys (https://mariadb.com/kb/en/library/file-key-management-encryption-plugin/)
RUN mkdir /etc/mysql/encryption
RUN openssl rand -hex 32 >> /etc/mysql/encryption/keyfile
RUN openssl rand -hex 128 > /etc/mysql/encryption/keyfile.key
RUN printf "1;" | cat - /etc/mysql/encryption/keyfile > /etc/mysql/encryption/keyfile.new
RUN mv -f /etc/mysql/encryption/keyfile.new /etc/mysql/encryption/keyfile
RUN openssl enc -aes-256-cbc -md sha1 -pass file:/etc/mysql/encryption/keyfile.key -in /etc/mysql/encryption/keyfile -out /etc/mysql/encryption/keyfile.enc

# Install configuration template handler
ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

COPY docker-itk-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-itk-entrypoint.sh
CMD [ "docker-itk-entrypoint.sh" ]
