{{ config(enabled=var('api_source') == 'google_ads') }}

with base as (
    select * 
    from {{ ref('stg_google_ads__account_tmp') }}
),

fields as (
    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__account_tmp')),
                staging_columns=get_account_columns()
            )
        }}
        {{ fivetran_utils.source_relation(
            union_schema_variable='google_ads_union_schemas', 
            union_database_variable='google_ads_union_databases') 
        }}
    from base
),

final as (
    select 
        id as account_id, 
        _fivetran_synced, 
        account_label_name, 
        currency_code, 
        name as account_name
    from fields
)

select * from final
