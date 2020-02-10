#!/bin/sh
rm -f tpid
nohup java -jar /opr/project/wechat-project-0.0.1-SNAPSHOT.jar --spring.profiles.active=online > /var/log/wechat-project/startup`date +%Y-%m-%d`.log 2>&1 &
echo $! > tpid
echo Start Success!
