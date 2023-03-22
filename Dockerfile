FROM alpine:3

ARG GENIEACS_VERSION

# root is used just to create the container, the genieacs runs with the user genieacs ;)
USER root

RUN addgroup -S genieacs && \ 
    adduser -G genieacs -S -h /opt/genieacs genieacs && \
    set -ex && \
    apk add --update --no-cache su-exec nodejs npm supervisor logrotate tzdata && \
    npm install -g genieacs@${GENIEACS_VERSION}

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
    chown genieacs:genieacs -R /opt/genieacs/ && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    apk del tzdata && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/lib/apt/lists/*

USER genieacs

WORKDIR /opt/genieacs

CMD ["supervisord"]