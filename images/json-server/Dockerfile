FROM node:14-alpine

MAINTAINER ITKDev <itkdev@mkb.aarhus.dk>


RUN npm install -g --production json-server \
 && rm -rf /root/.npm /usr/lib/node_modules/npm

EXPOSE 3000

VOLUME [ "/data" ]
WORKDIR /data

ENTRYPOINT ["json-server", "--host", "0.0.0.0"]
CMD ["--help"]