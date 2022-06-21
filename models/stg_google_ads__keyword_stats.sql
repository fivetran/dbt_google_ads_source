
with base as (

    select * 
    from {{ ref('stg_google_ads__keyword_stats_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__keyword_stats_tmp')),
                staging_columns=get_keyword_stats_columns()
            )
        }}
    from base
),

final as (
    
    select 
        _fivetran_id as keyword_id,
        customer_id as account_id, 
        date as date_day, 
        ad_group_id,
        ad_group_criterion_criterion_id as criterion_id,
        campaign_id, 
        clicks, 
        cost_micros / 1000000.0 as spend, 
        impressions
        
        {% for metric in var('google_ads__keyword_stats_passthrough_metrics', []) %}
        , {{ metric }}
        {% endfor %}
    from fields
)

select *
from final