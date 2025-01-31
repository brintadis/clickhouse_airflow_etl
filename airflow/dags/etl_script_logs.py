from airflow import DAG
from airflow_clickhouse_plugin.operators.clickhouse import ClickHouseOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'airflow',
    'retries': 1,
}

with DAG(
    dag_id='etl_script_logs',
    default_args=default_args,
    start_date=days_ago(2),
    schedule_interval='@hourly',
) as dag:

    run_clickhouse_query = ClickHouseOperator(
        task_id='run_clickhouse_query',
        database='default',
        sql='''
            INSERT INTO script_logs
            SELECT
                script_id,
                MIN(timestamp) AS start_timestamp,
                MAX(timestamp) AS end_timestamp,
                argMax(user, timestamp) AS user,
                argMax(communication_number, timestamp) AS communication_number,
                argMax(communication_id, timestamp) AS communication_id,
                argMax(mrf, timestamp) AS mrf,
                argMax(client_mrf, timestamp) AS client_mrf,
                argMax(crm_departament, timestamp) AS crm_departament,
                argMax(script_name, timestamp) AS script_name,
                argMax(script_owner, timestamp) AS script_owner,
                argMax(current_script_owner, timestamp) AS current_script_owner,
                argMax(script_responsible, timestamp) AS script_responsible,
                argMax(current_script_responsible, timestamp) AS current_script_responsible,
                argMax(nullIf(JSONExtractString(parameters, 'ACCOUNT_NUMBER'), ''), timestamp) AS account_number,
                argMax(nullIf(JSONExtractString(parameters, 'CALLER_ID'), ''), timestamp) AS caller_id,
                argMax(nullIf(JSONExtractString(parameters, 'COMMUNICATION_THEME'), ''), timestamp) AS communication_theme,
                argMax(nullIf(JSONExtractString(parameters, 'COMMUNICATION_DETAIL'), ''), timestamp) AS communication_detail,
                argMax(nullIf(JSONExtractString(parameters, 'COMMUNICATION_RESULT'), ''), timestamp) AS communication_result
            FROM script_logs_raw
            WHERE script_id NOT IN (SELECT script_id FROM script_logs)
            GROUP BY script_id;
        ''',
        clickhouse_conn_id='clickhouse_default',
    )

    run_clickhouse_query
