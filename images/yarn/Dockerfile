FROM node:16
LABEL maintainer "ITK Dev <itkdev@mkb.aarhus.dk>"

# Ensure packages are avaiable.
RUN apt-get update

RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app

ENTRYPOINT [ "/bin/bash", "/usr/local/bin/yarn" ]
