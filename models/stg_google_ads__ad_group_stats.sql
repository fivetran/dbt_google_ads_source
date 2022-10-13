{{ config(enabled=var('ad_reporting__google_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_google_ads__ad_group_stats_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__ad_group_stats_tmp')),
                staging_columns=get_ad_group_stats_columns()
            )
        }}
    from base
),

final as (
    
    select
        customer_id as account_id, 
        date as date_day, 
        cast(id as {{ dbt.type_string() }}) as ad_group_id, 
        campaign_id, 
        device,
        ad_network_type,
        clicks, 
        cost_micros / 1000000.0 as spend, 
        impressions
        
        {{ fivetran_utils.fill_pass_through_columns('google_ads__ad_group_stats_passthrough_metrics') }}

    from fields
)

select *
from final
