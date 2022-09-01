{{ config(enabled=var('ad_reporting__google_ads_enabled', True)) }}

select * 
from {{ var('keyword_stats') }}
