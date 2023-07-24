{{ config(enabled=var('ad_reporting__google_ads_enabled', True)) }}

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
        
    from base
),

final as (
    
    select 
        id as campaign_id, 
        updated_at,
        name as campaign_name,
        customer_id as account_id,
        advertising_channel_type,
        advertising_channel_subtype,
        start_date,
        end_date,
        serving_status,
        status,
        tracking_url_template,
        --Adding final_url_suffix because sometimes the UTMs are only configured in the final_url_suffix than the tracking template
        final_url_suffix,
        --Extracting UTMs for campaign report's use 
        coalesce( {{ dbt_utils.get_url_parameter('final_url_suffix', 'utm_source') }} ,
                {{ dbt_utils.get_url_parameter('tracking_url_template', 'utm_source') }} ) as utm_source,
        coalesce( {{ dbt_utils.get_url_parameter('final_url_suffix', 'utm_medium') }} ,
                {{ dbt_utils.get_url_parameter('tracking_url_template', 'utm_medium') }} ) as utm_medium,
        coalesce( {{ dbt_utils.get_url_parameter('final_url_suffix', 'utm_campaign') }} ,
                {{ dbt_utils.get_url_parameter('tracking_url_template', 'utm_campaign') }} ) as utm_campaign,
        row_number() over (partition by id order by updated_at desc) = 1 as is_most_recent_record
    from fields
)

select * 
from final