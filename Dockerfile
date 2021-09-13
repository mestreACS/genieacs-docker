FROM alpine:3

# just to create the container, the genieacs runs with the user genieacs
USER root

RUN addgroup -S genieacs && \ 
adduser -G genieacs -S -h /opt/genieacs genieacs && \
apk add --update --no-cache su-exec nodejs npm supervisor && \
 npm install -g genieacs@1.2.5

USER genieacs

RUN mkdir -p /opt/genieacs/ext /opt/genieacs/logs /opt/genieacs/supervisor/logs 

COPY genieacs.env /opt/genieacs/genieacs.env
#this is the default config file location of supervisord
COPY supervisor.conf /etc/supervisord.conf 
#the run.sh is used to pass the environments variables
COPY run.sh /opt/genieacs/run.sh
COPY logrotate.conf /etc/logrotate.conf

USER root

RUN chmod 600 /opt/genieacs/genieacs.env && \
chmod +x /opt/genieacs/run.sh && \
chown genieacs:genieacs -R /opt/genieacs/

USER genieacs

WORKDIR /opt/genieacs

CMD ["supervisord"]