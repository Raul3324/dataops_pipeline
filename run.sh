#!/bin/sh

set -e

# This is the hadoop part.

# This line copies the dataset into HDFS
docker cp data/input/application_train.csv hadoop-namenode:/application_train.csv

# These following lines create a folder for the dataset and move it there 
docker exec -it hadoop-namenode hdfs dfs -mkdir -p /user/data/input
docker exec -it hadoop-namenode hdfs dfs -put /application_train.csv /user/data/input/

# This line ensures that the dataset is not owned by root
docker exec -it hadoop-namenode hdfs dfs -chown -R spark /user/data


# This is the spark part.

# This line executes the spark job
docker exec spark-master /opt/bitnami/spark/bin/spark-submit \
  --packages io.delta:delta-spark_2.12:3.0.0 \
  --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
  --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
  /opt/spark/scripts/ingest_transform.py
