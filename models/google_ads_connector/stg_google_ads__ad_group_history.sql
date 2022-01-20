{{ config(enabled=var('api_source') == 'google_ads') }}

with base as (
    select * 
    from {{ ref('stg_google_ads__ad_group_history_tmp') }}
),

fields as (
    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__ad_group_history_tmp')),
                staging_columns=get_ad_group_history_columns()
            )
        }}
        {{ fivetran_utils.add_dbt_source_relation() }}
    from base
),

final as (
    select 
        id as ad_group_id,
        updated_at as updated_timestamp,
        _fivetran_synced, 
        ad_group_type, 
        campaign_id, 
        campaign_name, 
        name as ad_group_name, 
        status as ad_group_status
        {{ fivetran_utils.add_dbt_source_relation() }}
    from fields
),

most_recent as (
    select 
        *,
        row_number() over (partition by ad_group_id order by updated_timestamp desc) = 1 as is_most_recent_record
        {{ fivetran_utils.source_relation() }}
    from final
)

select * from most_recent