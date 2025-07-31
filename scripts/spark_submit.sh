#!/bin/sh

docker cp scripts/ingest_transform.py spark-master:/tmp

docker exec spark-master /opt/bitnami/spark/bin/spark-submit \
  --packages io.delta:delta-spark_2.12:3.0.0 \
  --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
  --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
  /tmp/ingest_transform.py

