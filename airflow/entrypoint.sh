#/bin/sh

# Acest fisier se asigura ca airflow db init se poate executa complet inainte de urmatoarele procese.

set -e

echo "Initializing Airflow DB..."
airflow db migrate

echo "Starting Airflow webserver..."
airflow webserver

echo "Starting Airflow scheduler..."
airflow scheduler
