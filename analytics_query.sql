SELECT
    timestamp,
    user,
    communication_number,
    communication_id,
    script_id,
    script_name,
    mrf,
    client_mrf,
    script_owner,
    current_script_owner,
    script_responsible,
    current_script_responsible,
    crm_departament,
    account_number,
    caller_id,
    communication_theme,
    communication_detail,
    communication_result
FROM script_logs
WHERE script_id = '7e3cfde7-53a7-40a9-b814-c373df9d8d04';
