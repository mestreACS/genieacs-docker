#! /bin/sh

while true 
do
logrotate -s /opt/genieacs/logrotate.status /etc/logrotate.conf
# de 6 em 6 horas
date
echo "Sleeping 6 hours"
sleep 6h
done