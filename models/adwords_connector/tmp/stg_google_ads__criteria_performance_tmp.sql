{{ config(enabled=var('api_source') == 'adwords') }}
{{
    fivetran_utils.union_data(
        table_identifier='google_ads__criteria_performance', 
        database_variable='google_ads_database', 
        schema_variable='google_ads_schema', 
        default_database=target.database,
        default_schema='google_ads',
        default_variable='google_ads__criteria_performance'
    )
}}