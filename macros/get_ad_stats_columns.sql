{% macro get_ad_stats_columns() %}

{% set columns = [
    {"name": "ad_group", "datatype": dbt.type_string()},
    {"name": "ad_group_id", "datatype": dbt.type_string()},
    {"name": "ad_id", "datatype": dbt.type_int()},
    {"name": "ad_network_type", "datatype": dbt.type_string()},
    {"name": "campaign_id", "datatype": dbt.type_int()},
    {"name": "clicks", "datatype": dbt.type_int()},
    {"name": "cost_micros", "datatype": dbt.type_int()},
    {"name": "customer_id", "datatype": dbt.type_int()},
    {"name": "date", "datatype": "date"},
    {"name": "device", "datatype": dbt.type_string()},
    {"name": "impressions", "datatype": dbt.type_int()},
    {"name": "keyword_ad_group_criterion", "datatype": dbt.type_string()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('google_ads__ad_stats_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}