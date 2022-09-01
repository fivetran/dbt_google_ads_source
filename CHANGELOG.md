# dbt_google_ads_source v0.8.0
## 🚨 Breaking Changes 🚨
- The `adwords` api version of the package has been fully removed. As the Fivetran Google Ads connector now requires the Google Ads API, this functionality is no longer used. ([#29](https://github.com/fivetran/dbt_google_ads_source/pull/29))
- The declaration of passthrough variables within your root `dbt_project.yml` has changed. To allow for more flexibility and better tracking of passthrough columns, you will now want to define passthrough metrics in the following format: ([#29](https://github.com/fivetran/dbt_google_ads_source/pull/29))
> This applies to all passthrough metrics within the `dbt_google_ads_source` package and not just the `google_ads__ad_stats_passthrough_metrics` example.
```yml
vars:
  google_ads__ad_stats_passthrough_metrics:
    - name: "my_field_to_include" # Required: Name of the field within the source.
      alias: "field_alias" # Optional: If you wish to alias the field within the staging model.
```

## 🎉 Feature Enhancements 🎉
PR [#29](https://github.com/fivetran/dbt_google_ads_source/pull/29) includes the following changes:

- Addition of the following staging models which pull from the source counterparts. The inclusion of the additional `_stats` source tables is to generate a more accurate representation of the Google Ads data. For example, not all Ad types are included within the `ad_stats` table. Therefore, the addition of the further grain reports will allow for more flexibility and accurate Google Ad reporting. 
  - `stg_google_ads__account_stats`
  - `stg_google_ads__ad_group_criterion_history`
  - `stg_google_ads__ad_group_stats`
  - `stg_google_ads__campaign_stats`
  - `stg_google_ads__keyword_stats`

- Inclusion of additional passthrough metrics: 
  - `google_ads__ad_group_stats_passthrough_metrics`
  - `google_ads__campaign_stats_passthrough_metrics`
  - `google_ads__keyword_stats_passthrough_metrics`
  - `google_ads__account_stats_passthrough_metrics`

- README updates for easier navigation and use of the package. 
- Addition of identifier variables for each of the source tables to allow for further flexibility in source table direction within the dbt project.
- Included grain uniqueness tests for each staging table. 


## Contributors
- [@bnealdefero](https://github.com/bnealdefero) ([#20](https://github.com/fivetran/dbt_google_ads/pull/20))

# dbt_google_ads_source v0.7.0
## 🚨 Breaking Changes 🚨
- The `api_source` variable is now defaulted to `google_ads` as opposed to `adwords`. The Adwords API has since been deprecated by Google and is now no longer the standard API for the Google Ads connector. Please ensure you are using a Google Ads API version of the Fivetran connector before upgrading this package. ([#28](https://github.com/fivetran/dbt_google_ads_source/pull/28))
  - Please note, the `adwords` version of this package will be fully removed from the package in August of 2022. This means, models under `models/adwords_connector` will be removed in favor of `models/google_ads_connector` models.
# dbt_google_ads_source v0.6.0
## 🚨 Breaking Changes 🚨
- The `account` source table has been renamed to be `account_history`. This has been reflected in this release. ([#25](https://github.com/fivetran/dbt_google_ads_source/pull/25))
- The `ad_final_url_history` model has been removed from the connector. The url fields are now references within the `final_urls` field within the `ad_history` table. ([#25](https://github.com/fivetran/dbt_google_ads_source/pull/25))
  - Please be aware that the logic in the `stg_google_ads__ad_history` model for the Google Ads API will only pull through the first url in the `final_urls` list. This column should contain only one url. However, in the even that two are include a test will warn you that the other urls have been removed from the final model.

# dbt_google_ads_source v0.5.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.


# dbt_google_ads_source v0.4.1

## Bug Fixes
- Renaming of the folder names within the `dbt_project.yml` to match the current spelling of the `/models/` folder names. This allows for the materialization of the `tmp` models to accurately be materialized as views. ([#19](https://github.com/fivetran/dbt_google_ads_source/pull/19))

## Contributors
- [NoToWarAlways](https://github.com/NoToWarAlways) ([#19](https://github.com/fivetran/dbt_google_ads_source/pull/19))

# dbt_google_ads_source v0.1.0 -> v0.4.0
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
