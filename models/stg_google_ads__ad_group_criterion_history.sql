
with base as (

    select * 
    from {{ ref('stg_google_ads__ad_group_criterion_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__ad_group_criterion_history_tmp')),
                staging_columns=get_ad_group_criterion_history_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as criterion_id,
        cast(ad_group_id as {{ dbt_utils.type_string() }}) as ad_group_id,
        base_campaign_id,
        updated_at,
        _fivetran_synced,
        type,
        status,
        keyword_match_type,
        keyword_text
    from fields
),

most_recent as (

    select 
        *,
        row_number() over (partition by criterion_id order by updated_at desc) = 1 as is_most_recent_record
    from final

)

select *
from most_recent
