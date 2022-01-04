#!/bin/sh

cd /app/server

mkdir plugins
cp -v ../spigot.jar .
cp -v ../floodgate-spigot.jar plugins/
cp -v ../Geyser-Spigot.jar plugins/

java -Xms2G -Xmx2G -XX:+UseG1GC -Dcom.mojang.eula.agree=true -jar spigot.jar nogui