docker exec -it airflow airflow users create \
  --username airflow \
  --firstname First \
  --lastname Last \
  --role Admin \
  --email airflow@example.com \
  --password airflow

