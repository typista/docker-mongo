#!/bin/bash
MONGODB_CONF=/etc/mongod.conf
sed -ri "s/# nojournal=true/nojournal=true/g" $MONGODB_CONF
/usr/bin/mongod --smallfiles &
CRON_TAB=/root/export/crontab.txt
if [ ! -f $CRON_TAB ];then
    wget $URL_GIT/crontab.txt -O $CRON_TAB
fi
crontab $CRON_TAB
