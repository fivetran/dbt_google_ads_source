with source as (

    select *
    from {{ ref('stg_google_ads__criteria_performance_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__criteria_performance_tmp')),
                staging_columns=get_criteria_performance_columns()
            )
        }}

    from source

), surrogate_key as (

    select
        *,
        {{ dbt_utils.surrogate_key(['date_day','campaign_id','ad_group_id','criteria']) }} as criteria_performance_id
    from renamed

)

select * from surrogate_key