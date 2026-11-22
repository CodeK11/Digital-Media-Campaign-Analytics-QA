# Data dictionary

## Simulated media delivery fact
| Field | Definition |
|---|---|
| report_date | Reporting date (ISO YYYY-MM-DD after standardisation) |
| campaign_id | Fictional campaign identifier |
| client | Fictional client label |
| campaign_name | Fictional campaign name |
| channel | Fictional channel grouping |
| platform | Fictional platform/source label |
| market | Market code |
| impressions | Simulated served impressions |
| clicks | Simulated clicks |
| media_cost_inr | Simulated media cost in INR |
| conversions | Simulated attributed conversions |
| attributed_revenue_inr | Simulated attributed revenue in INR |
| ctr | clicks / impressions |
| cpc_inr | media_cost_inr / clicks |
| cpm_inr | media_cost_inr / impressions × 1,000 |
| conversion_rate | conversions / clicks |
| cpa_inr | media_cost_inr / conversions |
| roas | attributed_revenue_inr / media_cost_inr |

## QA issue codes
- DATE_FORMAT_INVALID: date could not be parsed.
- PLATFORM_MISSING: source platform field is blank.
- IMPRESSIONS_MISSING: impressions value is missing.
- CLICKS_EXCEED_IMPRESSIONS: hard logical validation failure.
- NEGATIVE_MEDIA_COST: invalid negative spend.
- CAMPAIGN_NAME_WHITESPACE: leading/trailing whitespace requiring standardisation.
- DUPLICATE_CAMPAIGN_DAY: repeated campaign ID + reporting date; retain one source row and exclude the duplicate.

## GA4 public dataset output
See `sql/ga4_public_dataset_extract.sql`. GA4 metrics are event-based. Interpret the output according to GA4 export definitions; do not equate event counts with sessions or orders.
