{{ config(enabled=var('ad_reporting__google_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_google_ads__campaign_stats_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__campaign_stats_tmp')),
                staging_columns=get_campaign_stats_columns()
            )
        }}
    from base
),

final as (
    
    select 
        customer_id as account_id, 
        date as date_day, 
        id as campaign_id, 
        ad_network_type,
        device,
        clicks, 
        cost_micros / 1000000.0 as spend, 
        impressions
        
        {{ fivetran_utils.fill_pass_through_columns('google_ads__campaign_stats_passthrough_metrics') }}

    from fields
)

select *
from final
