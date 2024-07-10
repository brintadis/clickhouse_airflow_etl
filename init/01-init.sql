CREATE TABLE script_logs_raw (
    timestamp DateTime64(6),
    level String,
    sys String,
    mrf Nullable(String),
    user String,
    script_id String,
    script_name Nullable(String),
    script_key Nullable(String),
    script_version Nullable(Float64),
    script_process Nullable(String),
    action String,
    action_entity Nullable(String),
    action_id Nullable(String),
    action_data Nullable(String),
    message String,
    script_step_id Nullable(String),
    script_step_name Nullable(String),
    current_script_name Nullable(String),
    current_script_key Nullable(String),
    current_script_version Nullable(Float64),
    block_type String,
    parameters Nullable(String),
    timezone String,
    communication_id Nullable(Float64),
    communication_number Int64,
    integration_service_id Nullable(String),
    duration Float64,
    client_mrf String,
    session Nullable(Float64),
    script_owner Nullable(String),
    current_script_owner Nullable(String),
    script_responsible Nullable(String),
    current_script_responsible Nullable(String),
    crm_departament Nullable(String)
) ENGINE = MergeTree()
ORDER BY timestamp;

INSERT INTO script_logs_raw
FROM INFILE '/tmp/sm_test_data.csv'
FORMAT CSV;
