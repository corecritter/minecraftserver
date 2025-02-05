#!/bin/bash

/var/restore.sh

curl https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar --output /var/install/server.jar

cp /var/install/eula.txt /var/minecraft/eula.txt

for filename in /var/settings/*; do
    #if ! test -f /var/minecraft/$filename; then
    echo "copying $filename because it does not exist"
    cp $filename /var/minecraft/$(basename "$filename")
    #fi
done

backupJar="/var/minecraft/server.jar"
newJar="/var/install/server.jar"
shouldUpgrade=1;
if test -f $backupJar; then
    size1=$(stat -c %s "$backupJar")
    size2=$(stat -c %s "$newJar")
    if [ "$size1" -eq "$size2" ]; then
        shouldUpgrade=0;
    fi
fi

cp /var/install/server.jar /var/minecraft/server.jar
cd /var/minecraft

if [ "$shouldUpgrade" -eq 0 ]; then
    echo "Starting server"
    /var/backup.sh & java -Xmx4096M -Xms4096M -jar server.jar && fg
else
    echo "Starting with upgrade flag"
    /var/backup.sh & java -Xmx4096M -Xms4096M -jar server.jar --forceUpgrade && fg
fi