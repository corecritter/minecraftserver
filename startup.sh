#!/bin/sh

cp /var/install/eula.txt /var/data/minecraft/eula.txt
cp /var/install/server.jar /var/data/minecraft/server.jar

for filename in /var/settings/; do
    if ! test -f /var/data/minecraft/$filename; then
        echo "copying $filename because it does not exist"
        cp /var/settings/$filename /var/data/minecraft/$filename
    fi
done

cd /var/data/minecraft
java -Xmx1024M -Xms1024M -jar server.jar