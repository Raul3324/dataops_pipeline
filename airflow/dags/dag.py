from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

# Default settings 
default_args = {
    'start_date': datetime(2025, 1, 1),  
}

# DAG definition 
with DAG(
    'home_credit',       
    default_args=default_args,
    schedule_interval='@daily',         
    catchup = False,
    description='Ingest + transform the home credit dataset',
    tags=['spark', 'hdfs']
) as dag:

    # Running the Spark job inside the container
    run_spark_job = BashOperator(
        task_id='run_delta_ingestion',  # Task name in Airflow
        bash_command="""
        docker exec spark-master /opt/bitnami/spark/bin/spark-submit \
            --packages io.delta:delta-spark_2.12:3.0.0 \
            --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
            --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
            /opt/spark/scripts/ingest_transform.py
        """
    )

    # Task order
    run_spark_job

