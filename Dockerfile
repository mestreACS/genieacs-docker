FROM alpine:3

WORKDIR /opt/genieacs

ARG GENIEACS_VERSION

# root is used just to create the container, the genieacs runs with the user genieacs ;)
USER root

COPY genieacs.env /opt/genieacs/genieacs.env

#this is the default config file location of supervisord
COPY supervisor.conf /etc/supervisord.conf 

#the run.sh is used to pass the environments variables
COPY run.sh /opt/genieacs/run.sh

# The /etc/logrotate-wrapper.bash run logrotate every 1h (this is necessary to work with supervisord)
COPY logrotate-wrapper.bash /etc/logrotate-wrapper.bash

COPY logrotate.conf /etc/logrotate.conf

RUN addgroup -S genieacs && \ 
    adduser -G genieacs -S -h /opt/genieacs genieacs && \
    set -ex && \
    apk add --update --no-cache nodejs npm supervisor logrotate tzdata && \
    npm install -g genieacs@${GENIEACS_VERSION} && \
    mkdir -p /opt/genieacs/ext /opt/genieacs/logs /opt/genieacs/supervisor/logs && \
    chmod 600 /opt/genieacs/genieacs.env && \
    chmod +x /opt/genieacs/run.sh /etc/logrotate-wrapper.bash && \
    chown genieacs:genieacs -R /opt/genieacs/ && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    apk del tzdata npm && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/lib/apt/lists/* 

USER genieacs

CMD ["supervisord"]