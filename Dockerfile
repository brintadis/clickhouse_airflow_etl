FROM apache/airflow:latest

USER root

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    python3-dev \
    && apt-get clean

USER airflow

COPY requirements.txt .
RUN pip install -U airflow-clickhouse-plugin

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080
