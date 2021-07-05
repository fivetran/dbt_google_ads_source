{% if var('api_source') == 'adwords' %}
{% set staging_columns = get_adwords_final_url_performance_columns() %}
{% set spend_column = 'spend' %}
{% elif var('api_source') == 'google_ads' %}
{% set staging_columns = get_google_ads_final_url_performance_columns() %}
{% set spend_column = 'spend / 1000000.0' %}
{% endif %}

with source as (

    select *
    from {{ ref('stg_google_ads__final_url_performance_tmp') }}

),

renamed as (

    select
    
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_google_ads__final_url_performance_tmp')),
                staging_columns=staging_columns
            )
        }}

    from source

), 

url_fields as (

    select
        *,
        {{ dbt_utils.split_part('final_url', "'?'", 1) }} as base_url,
        {{ dbt_utils.get_url_host('final_url') }} as url_host,
        '/' || {{ dbt_utils.get_url_path('final_url') }} as url_path,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_source') }} as utm_source,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_medium') }} as utm_medium,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_campaign') }} as utm_campaign,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_content') }} as utm_content,
        {{ dbt_utils.get_url_parameter('final_url', 'utm_term') }} as utm_term
    from renamed

), 

micros_cleanup as (

    select
        _fivetran_id,
        _fivetran_synced,
        account_name,
        ad_group_id,
        ad_group_name,
        ad_group_status,
        campaign_id,
        campaign_name,
        campaign_status,
        clicks,
        {{ spend_column }} as spend,
        date_day,
        final_url,
        external_customer_id,
        impressions,
        base_url,
        url_host,
        url_path,
        utm_source,
        utm_medium,
        utm_campaign,
        utm_content,
        utm_term
    from url_fields

), surrogate_key as (

    select
        *,
        {{ dbt_utils.surrogate_key(['date_day','campaign_id','ad_group_id','final_url']) }} as final_url_performance_id
    from micros_cleanup

)

select * from surrogate_key