#!/usr/bin/env bash

# Initialize the database
airflow db init

# Create an admin user if it doesn't exist
if ! airflow users list | grep -q "admin"; then
    airflow users create \
    --username admin \
    --firstname admin \
    --lastname admin \
    --role Admin \
    --email admin@example.com \
    --password admin
fi

# Start the web server
exec airflow webserver &
exec airflow scheduler
