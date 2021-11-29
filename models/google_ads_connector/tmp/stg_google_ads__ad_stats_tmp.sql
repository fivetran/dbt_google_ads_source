{{ config(enabled=var('api_source') == 'google_ads') }}
{{
    fivetran_utils.union_data(
        table_identifier='ad_stats',
        database_variable='google_ads_database', 
        schema_variable='google_ads_schema', 
        default_database=target.database,
        default_schema='google_ads',
        default_variable='google_ads__ad_stats',
        union_schema_variable='google_ads_union_schemas',
        union_database_variable='google_ads_union_databases'
    )
}}