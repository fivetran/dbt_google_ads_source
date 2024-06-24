{% macro get_campaign_stats_columns() %}

{% set columns = [
    {"name": "_fivetran_id", "datatype": dbt.type_string()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "ad_network_type", "datatype": dbt.type_string()},
    {"name": "clicks", "datatype": dbt.type_int()},
    {"name": "cost_micros", "datatype": dbt.type_int()},
    {"name": "customer_id", "datatype": dbt.type_int()},
    {"name": "date", "datatype": "date"},
    {"name": "device", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_int()},
    {"name": "impressions", "datatype": dbt.type_int()},
    {"name": "conversions", "datatype": dbt.type_int()},
    {"name": "conversion_value", "datatype": dbt.type_int()},
    {"name": "view_through_conversions", "datatype": dbt.type_int()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('google_ads__campaign_stats_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}
