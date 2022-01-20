{{ config(enabled=var('api_source') == 'adwords') }}

with source as (
    select *
    from {{ ref('stg_google_ads__click_performance_tmp') }}
),

renamed as (
    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__click_performance_tmp')),
                staging_columns=get_click_performance_columns()
            )
        }}
        {{ fivetran_utils.source_relation(
            union_schema_variable='google_ads_union_schemas', 
            union_database_variable='google_ads_union_databases') 
        }}
    from source
)

select * from renamed