
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
        
    from base
),

final as (
    
    select 
        cast(id as {{ dbt_utils.type_string() }}) as ad_group_id,
        updated_at,
        _fivetran_synced, 
        type as ad_group_type, 
        campaign_id, 
        campaign_name, 
        name as ad_group_name, 
        status as ad_group_status
    from fields
),

most_recent as (

    select 
        *,
        row_number() over (partition by ad_group_id order by updated_at desc) = 1 as is_most_recent_record
    from final

)

select * from most_recent