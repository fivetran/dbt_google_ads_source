{{ config(enabled=var('api_source') == 'google_ads') }}

with base as (
    select * 
    from {{ ref('stg_google_ads__campaign_history_tmp') }}
),

fields as (
    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__campaign_history_tmp')),
                staging_columns=get_campaign_history_columns()
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
        id as campaign_id, 
        updated_at as updated_timestamp, 
        _fivetran_synced, 
        name as campaign_name,
        customer_id as account_id,
        source_relation
    from fields
),

most_recent as (
    select 
        *,
        row_number() over (partition by campaign_id order by updated_timestamp desc) = 1 as is_most_recent_record
    from final
)

select * from most_recent