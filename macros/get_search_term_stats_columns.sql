{% macro get_search_term_stats_columns() %}

{% set columns = [
    {"name": "_fivetran_id", "datatype": dbt.type_string()},
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "absolute_top_impression_percentage", "datatype": dbt.type_float()},
    {"name": "ad_group_id", "datatype": dbt.type_int()},
    {"name": "average_cpc", "datatype": dbt.type_float()},
    {"name": "campaign_id", "datatype": dbt.type_int()},
    {"name": "clicks", "datatype": dbt.type_int()},
    {"name": "conversions", "datatype": dbt.type_float()},
    {"name": "conversions_from_interactions_rate", "datatype": dbt.type_float()},
    {"name": "conversions_from_interactions_value_per_interaction", "datatype": dbt.type_float()},
    {"name": "cost_micros", "datatype": dbt.type_int()},
    {"name": "ctr", "datatype": dbt.type_float()},
    {"name": "customer_id", "datatype": dbt.type_int()},
    {"name": "date", "datatype": "date"},
    {"name": "impressions", "datatype": dbt.type_int()},
    {"name": "resource_name", "datatype": dbt.type_string()},
    {"name": "search_term", "datatype": dbt.type_string()},
    {"name": "search_term_match_type", "datatype": dbt.type_string()},
    {"name": "status", "datatype": dbt.type_string()},
    {"name": "top_impression_percentage", "datatype": dbt.type_float()},
    {"name": "view_through_conversions", "datatype": dbt.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
