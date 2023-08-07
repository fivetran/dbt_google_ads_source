{{ config(enabled=var('ad_reporting__google_ads_enabled', True)) }}

select * 
from {{ var('campaign_history') }}
where _fivetran_active