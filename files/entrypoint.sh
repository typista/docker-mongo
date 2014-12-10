#!/bin/bash
LOCALTIME=/etc/localtime
if [ ! -L $LOCALTIME ]; then
  rm $LOCALTIME
  ln -s /usr/share/zoneinfo/Asia/Tokyo $LOCALTIME
fi
HOSTNAME=`hostname`

MONGODB_CONF=/etc/mongod.conf
sed -ri "s/# nojournal=true/nojournal=true/g" $MONGODB_CONF

#mkdir -p /data/db
/usr/bin/mongod --smallfiles &
crontab /root/crontab.txt
/etc/init.d/crond start
/usr/bin/tail -f /dev/null
