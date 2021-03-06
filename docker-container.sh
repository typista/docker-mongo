#!/bin/sh
USER=typista
if [ "$1" = "" ];then
	echo "Input parametor FQDN [and TAG]"
else
	__FQDN__=$1
	__HOSTNAME__=`echo $__FQDN__ | sed -r "s/\./_/g"`
	FULLPATH=$(cd `dirname $0`; pwd)/`basename $0`
	DIR=`dirname $FULLPATH`
	REPO=`basename $DIR`
	REPO=`echo $REPO | sed -r "s/docker\-//g"`
	IMAGE=$USER/$REPO
	if [ "$2" != "" ];then
		IMAGE=$IMAGE:$2
	else
		VERSION=`docker images | grep "$IMAGE " | sort | tail -1 | awk '{print $2}'`
		if [ "$VERSION" != "" ];then
			IMAGE=$IMAGE:$VERSION
		fi
	fi
	docker run -d --privileged --restart=always --name="$__FQDN__" --hostname="$__HOSTNAME__" \
		-p 27017:27017 \
		-v ${PWD}/export/root/:/root/export/ \
		-v ${PWD}/export/mongo/:/data/db/ \
		$IMAGE
	RESTART=./restart.sh
	echo "docker rm -f $__FQDN__" > $RESTART
	echo "$0 $__FQDN__ &" >> $RESTART
	chmod +x $RESTART
	BOOT=./container/docker-boot-$__HOSTNAME__.sh
	BOOT_OFF=./container/docker-boot-off-$__HOSTNAME__.sh
	REMOVE=./container/docker-remove-$__HOSTNAME__.sh
	echo "./docker-boot.sh $__FQDN__" > $BOOT
	echo "./docker-boot-off.sh $__FQDN__" > $BOOT_OFF
	echo "docker rm -f $__FQDN__" > $REMOVE
	echo "sudo rm -rf /var/www/$__HOSTNAME__" >> $REMOVE
	chmod +x $BOOT
	chmod +x $BOOT_OFF
	chmod +x $REMOVE
	$BOOT
fi

