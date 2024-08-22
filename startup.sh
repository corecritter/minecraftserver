#!/bin/bash

/var/restore.sh

cp /var/install/eula.txt /var/minecraft/eula.txt
cp /var/install/server.jar /var/minecraft/server.jar

for filename in /var/settings/*; do
    if ! test -f /var/minecraft/$filename; then
        echo "copying $filename because it does not exist"
        cp $filename /var/minecraft/$(basename "$filename")
    fi
done

cd /var/minecraft
ls -al
/var/backup.sh & java -Xmx4096M -Xms4096M -jar server.jar && fg