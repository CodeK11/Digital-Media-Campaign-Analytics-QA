# Source register

| ID | Source | Type | Use | Date coverage / extraction | Limitations |
|---|---|---|---|---|---|
| SRC-01 | `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` | Official public GA4 sample | Historical web-event analytics | Event dates 2020-11-01 to 2021-01-31; query executed and CSV exported 2026-11-22 | Obfuscated; historical; grouped user counts are not additive unique users; event value is not necessarily purchase revenue; not paid-media delivery |
| SRC-02 | Agency-style media delivery report generated for this project | Simulated practice data | Excel/Power BI workflow, media KPI calculations and QA demonstrations | 2026-08-01 to 2026-08-31 | Entirely fictional; not actual Ebiquity, client or platform results |

## GA4 extraction grain and fields

The exported query result has one row per `event_date`, `event_name`, `device_category`, `country` and `traffic_medium`. It contains `event_count`, `unique_users` (distinct users within that row's group) and `event_value_usd` (sum of source event value for all events in that group).

## Official reference

Google for Developers — GA4 ecommerce sample dataset: https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset
Google BigQuery basic queries: https://developers.google.com/analytics/bigquery/basic-queries
