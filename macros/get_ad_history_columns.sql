{% macro get_ad_history_columns() %}

{% set columns = [
    {"name": "ad_group_id", "datatype": dbt_utils.type_int()},
    {"name": "display_url", "datatype": dbt_utils.type_string()},
    {"name": "final_urls", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}
