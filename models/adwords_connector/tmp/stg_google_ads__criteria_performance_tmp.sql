{{ config(enabled=var('api_source') == 'adwords') }}
{{
    fivetran_utils.union_data(
        table_identifier='criteria_performance',
        database_variable='google_ads_database', 
        schema_variable='google_ads_schema', 
        default_database=target.database,
        default_schema='google_ads',
        default_variable='google_ads__criteria_performance',
        union_schema_variable='google_ads_union_schemas',
        union_database_variable='google_ads_union_databases'
    )
}}