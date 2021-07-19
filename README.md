# Google Ads (Source)

This package models Google Ads data from [Fivetran's connector](https://fivetran.com/docs/applications/google-ads).

## Models

This package contains staging models, designed to work simultaneously with our [Google Ads modeling package](https://github.com/fivetran/dbt_google_ads) and our [multi-platform Ad Reporting package](https://github.com/fivetran/dbt_ad_reporting).  The staging models name columns consistently across all packages:
 * Boolean fields are prefixed with `is_` or `has_`
 * Timestamps are appended with `_timestamp`
 * ID primary keys are prefixed with the name of the table. For example, the campaign table's ID column is renamed `campaign_id`.

## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

## Configuration
This package allows users to leverage either the Adwords API or the Google Ads API. You will be able to determine which API your connector is using by navigating within your Fivetran UI to the `setup` tab -> `edit connection details` link -> and reference the `API configuration` used. 

You will want to refer to the respective configuration steps below based off the API used by your connector. Additionally, if your connector is setup using the Google Ads API then you will need to configure your `dbt_project.yml` with the below variable:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    api_source: google_ads  ## adwords by default
```
### Adwords API Configuration
To use this package, you will need to pull the following custom reports through Fivetran:

* Destination Table Name: `final_url_performance`
* Report Type: `FINAL_URL_REPORT`
* Fields:
  * AccountDescriptiveName
  * AdGroupId
  * AdGroupName
  * AdGroupStatus
  * CampaignId
  * CampaignName
  * CampaignStatus
  * Clicks
  * Cost
  * Date
  * EffectiveFinalUrl
  * ExternalCustomerId
  * Impressions

* Destination Table Name: `criteria_performance`
* Report Type: `CRITERIA_PERFORMANCE_REPORT`
* Fields:
  * AccountDescriptiveName
  * AdGroupId
  * AdGroupName
  * AdGroupStatus
  * CampaignId
  * CampaignName
  * CampaignStatus
  * Clicks
  * Cost
  * Criteria
  * CriteriaDestinationUrl
  * CriteriaType
  * Date
  * ExternalCustomerId
  * Id
  * Impressions

* Destination Table Name: `click_performance`
* Report Type: `CLICK_PERFORMANCE_REPORT`
* Fields:
  * AccountDescriptiveName
  * AdGroupId
  * AdGroupName
  * AdGroupStatus
  * CampaignId
  * CampaignName
  * CampaignStatus
  * Clicks
  * CriteriaId
  * Date
  * ExternalCustomerId
  * GclId

### Google Ads API Configuration
To use this package, you will need to pull the following custom reports through Fivetran (you will notice `criteria_performance` and `click_performance` are omitted as these Adwords reports are not obtainable with the Google Ads API):

* Destination Table Name: `final_url_performance`
* Report Name: `LANDING_PAGE_VIEW`
* Fields:
  * customer.descriptive_name
  * ad_group.id
  * ad_group.name
  * ad_group.status
  * campaign.name
  * campaign.id
  * campaign.status
  * campaign.end_date
  * campaign.start_date
  * metrics.clicks
  * metrics.cost_micros
  * customer.id
  * segments.date
  * expanded_landing_page_view.expanded_final_url
  * landing_page_view.unexpanded_final_url
  * metrics.impressions

### Differing Source Table Names
The package assumes that the corresponding destination tables are named `final_url_performance` (for Adwords and Google Ads API), `criteria_performance`, and `click_performance` (for Adwords API only). If these tables have different names in your destination, enter the correct table names in the `google_ads__final_url_performance`, `google_ads__click_performance`, and `google_ads__criteria_performance` variables so that the package can find them:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    google_ads__final_url_performance: "{{ ref('a_model_you_wrote') }}"
    google_ads__click_performance: adwords.click_performance_report
```
### Source Schema is Named Differently
By default, this package will look for your Google Ads data in the `adwords` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Google Ads data is, please add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    google_ads_schema: your_schema_name
    google_ads_database: your_database_name
```

### Changing the Build Schema
By default this package will build the Google Ads staging models within a schema titled (<target_schema> + `_stg_google_ads`) in your target database. If this is not where you would like your Google Ads  staging data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
    google_ads_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions or feedback, or need help? Book a time during our office hours [here](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or shoot us an email at solutions@fivetran.com.
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate dbt transformations with Fivetran [here](https://fivetran.com/docs/transformations/dbt).
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
