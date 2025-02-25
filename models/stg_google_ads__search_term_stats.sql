
with base as (

    select * 
    from {{ ref('stg_google_ads__search_term_stats_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__search_term_stats_base')),
                staging_columns=get_search_term_stats_columns()
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
        source_relation, 
        _fivetran_id as search_term_id,
        customer_id as account_id,
        date as date_day,
        cast(ad_group_id as {{ dbt.type_string() }}) as ad_group_id,
        campaign_id,
        search_term,
        search_term_match_type,
        status as search_term_status,
        {# resource_name #}

        coalesce(clicks, 0) as clicks, 
        coalesce(cost_micros, 0) / 1000000.0 as spend, 
        coalesce(impressions, 0) as impressions,
        coalesce(conversions, 0) as conversions,
        -- conversions value is not available yet in this source table
        {# coalesce(conversions_value, 0) as conversions_value, #}
        coalesce(view_through_conversions, 0) as view_through_conversions

    from fields
)

select *
from final
