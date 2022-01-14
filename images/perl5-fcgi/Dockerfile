FROM ubuntu:16.04
LABEL maintainer "ITK Dev <itkdev@mkb.aarhus.dk>"

# Ensure packages are avaiable.
RUN apt-get update

RUN apt-get install -y language-pack-en-base \
    software-properties-common \
    apt-utils \
&& locale-gen en_US.UTF-8 en_DK.UTF-8 en_GB.UTF-8

# Clean up
RUN apt-get remove -y software-properties-common language-pack-en-base \
&& apt-get autoremove -y

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    libfcgi-perl \
    perl \
    fcgiwrap \
    wget \
    build-essential \
    autoconf \
    automake \
    libtool \
    gdb \
    libexpat1-dev \
    libssl-dev \
    libmysqlclient-dev \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install perl modules
RUN PERL_MM_USE_DEFAULT=1 \
  cpan install CGI \
  Data::Dumper \
  Date::Calc \
  DBI \
  DNS::ZoneParse \
  Email::MIME \
  Email::Sender::Simple \
  Email::Sender::Transport::SMTP \
  Email::Sender::Transport::SMTP::Persistent \
  Email::Simple \
  Email::Simple::Creator \
  Encode \
  Exporter \
  File::Basename \
  File::Path \
  File::Temp \
  HTML::TreeBuilder \
  Net::SSLeay \
  HTTP::CookieJar \
  HTTP::Tiny \
  IO::Socket::SSL \
  IO::Socket::SSL::Utils \
  JSON \
  MIME::Base64 \
  Net::FTP \
  Net::IDN::Encode \
  Net::POP3 \
  Net::SMTP \
  Text::CSV_XS \
  Text::Levenshtein \
  Time::HiRes \
  Time::Piece \
  Try::Tiny \
  URI \
  URI::Escape \
  XML::SAX::Expat \
  XML::Parser \
  XML::LibXML \
  XML::LibXML::XPathContext \
  XML::Simple \
  DBD::mysql

# Add mhsendmail for mailhog
ADD https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 /usr/local/bin/mhsendmail
RUN chmod +x /usr/local/bin/mhsendmail

# Install configuration template handler
ADD https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
RUN mkdir -p /etc/confd/conf.d

EXPOSE 9000

WORKDIR /app

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
CMD [ "docker-entrypoint.sh" ]
