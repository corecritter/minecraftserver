#!/bin/sh

cp /var/install/eula.txt /var/minecraft/eula.txt
cp /var/install/server.jar /var/minecraft/server.jar

for filename in /var/settings/*; do
    if ! test -f /var/minecraft/$filename; then
        echo "copying $filename because it does not exist"
        cp $filename file_name=$(basename "$filename")
    fi
done

cd /var/minecraft
java -Xmx1024M -Xms1024M -jar server.jar