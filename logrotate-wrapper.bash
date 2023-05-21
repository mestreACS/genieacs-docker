#! /bin/sh

while true 
do
# de 12 em 12 horas
sleep 12h
logrotate -s /opt/genieacs/logrotate.status /etc/logrotate.conf
done