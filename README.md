# Home Credit Data Pipeline

This project uses a mini data platform powered by Docker, Apache Spark, Hadoop (HDFS), Airflow, and Delta Lake — simulating a data ingestion and transformation pipeline.

## Data source
The data can be found in the Kaggle Home Credit Default Risk page https://www.kaggle.com/c/home-credit-default-risk. 
More specifically, the files used are application_train.csv, application_test.csv and bureau.csv

## Project structure

- compose.yaml - docker setup for Airflow, Spark and HDFS
- run.sh - script to run the pipeline manually
- scripts/ingest_transform.py - spark job
- airflow/dags/home_credit.py - dag to run the spark job
- diagram.png - draw.io diagram of data flow
- data/input - contains the input dataset

## Running the project

### Start the docker containers

```bash
# docker compose up
```

### Create the airflow user (only for the first time)

```bash
docker exec -it airflow airflow users create \
  --username airflow \
  --firstname First \
  --lastname Last \
  --role Admin \
  --email airflow@example.com \
  --password airflow
```

The WebUI is found at localhost:8082.

### Run the pipeline

Run the pipeline, either by running the run.sh script, or through the Airflow WebUI.

### Pipeline data flow

The pipeline uploads the dataset (application_train.csv) to HDFS, drops the rows missing TARGET, then writes the results as a delta lake table to HDFS at
data/output/application_train_delta/

### Bonus task

The bonus task is implemented in a Jupyter Notebook under notebooks/, using only local files and Python.
It consists of a series of operations on the datasets application_train and bureau, from cleaning them to feature engineering, and, finally,
to training an XGBOOST classifier on them.
