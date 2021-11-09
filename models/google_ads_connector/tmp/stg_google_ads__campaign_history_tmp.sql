{{ config(enabled=var('api_source') == 'google_ads') }}
{{
    fivetran_utils.union_data(
        table_identifier='campaign_history',
        database_variable='google_ads_database', 
        schema_variable='google_ads_schema', 
        default_database=target.database,
        default_schema='google_ads',
        default_variable='google_ads__campaign_history'
    )
}}