#!/bin/bash
MONGODB_CONF=/etc/mongod.conf
sed -ri "s/# nojournal=true/nojournal=true/g" $MONGODB_CONF
/usr/bin/mongod --smallfiles &
