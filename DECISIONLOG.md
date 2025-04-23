# Decision Log
## Ads Associated with Multiple Ad Groups
It was discovered within the source data that a single Ad can be associated with multiple ad groups on any given day. Because of this, it was determined that the `is_most_recent_record` logic within the `stg_google_ads__ad_history` model needed to account for the `ad_group_id` as well as the individual `ad_id`. As a result, the most recent record of an ad could possibly contain a unique combination of the `ad_id` and the `ad_group_id`.

This logic was only applied to the `stg_google_ads__ad_history` model as it was discovered this relationship was unique to ads and ad groups. If you experience this relationship among any of the other ad hierarchies, please open and [issue](https://github.com/fivetran/dbt_google_ads_source/issues/new?assignees=&labels=bug%2Ctriage&template=bug-report.yml&title=%5BBug%5D+%3Ctitle%3E) and we can continue the discussion!


## Why don't metrics add up across different grains (Ex. ad level vs campaign level)?
Not all ads are served at the ad level. In other words, there are some ads that are served only at the ad group, campaign, etc. levels. The implications are that since not ads are included in the ad-level report, their associated spend, for example, won't be included at that grain. Therefore your spend totals may differ across the ad grain and another grain. 

This is a reason why we have broken out the ad reporting packages into separate hierarchical end models (Ad, Ad Group, Campaign, and more). Because if we only used ad-level reports, we could be missing data.


## Inclusion of Search Term Keyword Qualifiers
In the `stg_google_ads__search_term_keyword_stats` model, some keywords may be prepended with plus signs (`+`) or may be wrapped in 2 single quotes (`''keyword''`). The former is a legacy of Broad Match Modifier (BMM), which was [deprecated](https://support.google.com/google-ads/answer/10286719?hl=en) and merged into Phrase Match in July 2021 by Google. The latter likely indicates a phrase match for the keyword, though it may not match the `search_term_match_type` value for the record.

We have opted to leave these qualifiers in the `keyword_text` values, rather than strip them out. Please reach out and create an [issue](https://github.com/fivetran/dbt_google_ads_source/issues) if you would like cleaned `keyword_text` values for standardization.