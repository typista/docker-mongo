#!/bin/bash
REPO=docker-mongo
export URL_GIT=https://raw.githubusercontent.com/typista/$REPO/master/files

LOCALTIME=/etc/localtime
if [ ! -L $LOCALTIME ]; then
	rm $LOCALTIME
	ln -s /usr/share/zoneinfo/Asia/Tokyo $LOCALTIME
fi
EXEC1ST=/root/export/exec1st.sh
if [ ! -f $EXEC1ST ];then
	wget $URL_GIT/exec1st.sh -O $EXEC1ST
fi
if [ ! -x $EXEC1ST ];then
	chmod +x $EXEC1ST
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
$EXEC1ST > /dev/null 2>&1
/etc/init.d/crond start
/usr/bin/tail -f /dev/null
