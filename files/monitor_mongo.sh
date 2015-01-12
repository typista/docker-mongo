#!/bin/sh
#$MONITOR_PS_LIST
NOW=`date '+%Y-%m-%d %H:%M:%S'`
LOG=/root/export/shell.log
MONGO=/usr/bin/mongod
IS_EXEC=`cat $MONITOR_PS_LIST | grep $MONGO | grep -v grep`
MONGO_PS=`echo $IS_EXEC | awk '{print $2}'`
LOAD_AVERAGE=`uptime | sed -e 's/.*average: //g' -e 's/,//g' | awk '{print $1}'`
THRESHOLD=`grep 'processor' /proc/cpuinfo | wc -l`
COMPARE=`echo "${THRESHOLD} < ${LOAD_AVERAGE}" | bc` 
touch $LOG
echo "=================" >> $LOG
echo $NOW >> $LOG
echo "load average:"$LOAD_AVERAGE >> $LOG
echo "threshold:"$THRESHOLD >> $LOG
echo "compare:"$COMPARE >> $LOG
if [ ${COMPARE} = 1 -a "$MONGO_PS" != "" ]; then
	echo "kill" >> $LOG
	kill -9 $MONGO_PS
	sleep 3
	IS_EXEC=""
fi
if [ "$IS_EXEC" = "" ]; then
	echo "start" >> $LOG
	$MONGO --smallfiles &
fi
