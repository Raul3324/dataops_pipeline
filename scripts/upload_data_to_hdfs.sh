#!/bin/sh
docker cp ../data/input/application_train.csv hadoop-namenode:/application_train.csv
docker exec -it hadoop-namenode hdfs dfs -mkdir -p /user/data/input
docker exec -it hadoop-namenode hdfs dfs -put /application_train.csv /user/data/input/
docker exec -it hadoop-namenode hdfs dfs -chown -R spark /user/data
