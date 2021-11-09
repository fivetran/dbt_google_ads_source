# dbt_google_ads_source v0.5.0

## Features
- Allow for multiple sources by unioning source tables across multiple Google Ads connectors.
  - Refer to the [README](https://github.com/fivetran/dbt_google_ads_source#unioning-multiple-google_ads-connectors) for more details.

## Under the Hood
- Unioning: The unioning occurs in the tmp models using the `fivetran_utils.union_data` macro.
- Unique tests: Because columns that were previously used for unique tests may now have duplicate fields across multiple sources, these columns are combined with the new `source_relation` column for unique tests and tested using the `dbt_utils.unique_combination_of_columns` macro.
- Source Relation column: To distinguish which source each field comes from, we added a new `source_relation` column in each staging model and applied the `fivetran_utils.source_relation` macro. 

## Contributors
- [@pawelngei](https://github.com/pawelngei)

# dbt_google_ads_source v0.4.1

## Bug Fixes
- Renaming of the folder names within the `dbt_project.yml` to match the current spelling of the `/models/` folder names. This allows for the materialization of the `tmp` models to accurately be materialized as views. ([#19](https://github.com/fivetran/dbt_google_ads_source/pull/19))

## Contributors
- [NoToWarAlways](https://github.com/NoToWarAlways) ([#19](https://github.com/fivetran/dbt_google_ads_source/pull/19))

# dbt_google_ads_source v0.1.0 -> v0.4.0
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!