
with base as (

    select * 
    from {{ ref('stg_google_ads__ad_stats_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__ad_stats_tmp')),
                staging_columns=get_ad_stats_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        customer_id as account_id, 
        date as date_day, 
        coalesce(cast(ad_group_id as {{ dbt_utils.type_string() }}), {{ dbt_utils.split_part(string_text='ad_group', delimiter_text="'adGroups/'", part_number=2) }}) as ad_group_id,
        keyword_ad_group_criterion,
        ad_network_type,
        device,
        ad_id, 
        campaign_id, 
        clicks, 
        cost_micros / 1000000.0 as spend, 
        impressions
        
        {% for metric in var('google_ads__ad_stats_passthrough_metrics', []) %}
        , {{ metric }}
        {% endfor %}
    from fields
)

select * from final
