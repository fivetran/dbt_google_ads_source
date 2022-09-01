{% macro get_campaign_history_columns() %}

{% set columns = [
    {"name": "advertising_channel_subtype", "datatype": dbt_utils.type_string()},
    {"name": "advertising_channel_type", "datatype": dbt_utils.type_string()},
    {"name": "customer_id", "datatype": dbt_utils.type_int()},
    {"name": "end_date", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "serving_status", "datatype": dbt_utils.type_string()},
    {"name": "start_date", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "tracking_url_template", "datatype": dbt_utils.type_string()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}