#!/bin/bash
MONGODB_CONF=/etc/mongod.conf
sed -ri "s/# nojournal=true/nojournal=true/g" $MONGODB_CONF
/usr/bin/mongod --smallfiles &
CRON_TAB=/root/export/crontab.txt
if [ ! -f $CRON_TAB ];then
    wget $URL_GIT/crontab.txt -O $CRON_TAB
fi
START=/root/export/start.sh
if [ ! -f $START ];then
    wget $URL_GIT/start.sh -O $START
fi
if [ ! -x $START ];then
    chmod +x $START
fi
MONITOR=/root/export/monitor_mongo.sh
if [ ! -f $MONITOR ];then
    wget $URL_GIT/monitor_mongo.sh -O $MONITOR
fi
if [ ! -x $MONITOR ];then
    chmod +x $MONITOR
fi
crontab $CRON_TAB
