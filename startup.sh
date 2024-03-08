#!/bin/sh

cp /var/install/eula.txt /var/data/minecraft/eula.txt
cp /var/install/server.jar /var/data/minecraft/server.jar
cd /var/data/minecraft
java -Xmx1024M -Xms1024M -jar server.jar