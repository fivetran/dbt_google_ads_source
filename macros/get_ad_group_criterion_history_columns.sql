{% macro get_ad_group_criterion_history_columns() %}

{% set columns = [
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "ad_group_id", "datatype": dbt_utils.type_int()},
    {"name": "base_campaign_id", "datatype": dbt_utils.type_int()},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "type", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "keyword_match_type", "datatype": dbt_utils.type_string()},
    {"name": "keyword_text", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
