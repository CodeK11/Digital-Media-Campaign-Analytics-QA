# GA4 public sample extraction guide

## Source and scope

The source is Google's public, obfuscated Google Merchandise Store GA4 sample in BigQuery:

`bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`

The extracted window is 1 November 2020–31 January 2021. This is web-event data, not paid-media impressions, clicks, spend or conversions reported by an advertising platform.

## Query used in this project

Open https://console.cloud.google.com/bigquery, select a Google Cloud project, open a new SQL query, and run:

```sql
SELECT
    event_date,
    event_name,
    device.category AS device_category,
    geo.country AS country,
    traffic_source.medium AS traffic_medium,
    COUNT(*) AS event_count,
    COUNT(DISTINCT user_pseudo_id) AS unique_users,
    SUM(event_value_in_usd) AS event_value_usd
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY
    event_date,
    event_name,
    device_category,
    country,
    traffic_medium
ORDER BY
    event_date,
    event_count DESC;
```

The query returns one row per combination of event date, event name, device category, country and traffic medium. It is an aggregate output, not the raw event export.

## Export and save

1. Run the query and wait for it to succeed.
2. In Query results, select **Save results → CSV (local file)**.
3. Save or move the downloaded file to `data/processed/ga4_web_analytics.csv`.
4. Record the extraction date and retain this query with the project.

## Import into Power BI

1. Home → Get data → Text/CSV → select `data/processed/ga4_web_analytics.csv` → Transform Data.
2. Keep `event_date` as Text initially. Set `event_name`, `device_category`, `country` and `traffic_medium` to Text; `event_count` and `unique_users` to Whole Number; `event_value_usd` to Decimal Number.
3. Add a Custom Column named `Event Date` with:

```powerquery
#date(
    Number.FromText(Text.Start([event_date], 4)),
    Number.FromText(Text.Range([event_date], 4, 2)),
    Number.FromText(Text.End([event_date], 2))
)
```

4. Set `Event Date` to Date, rename the query `GA4_Web_Analytics`, then Close & Apply.

## Measures used

```dax
GA4 Total Events =
SUM(GA4_Web_Analytics[event_count])

GA4 Unique Users =
SUM(GA4_Web_Analytics[unique_users])

GA4 Event Value USD =
SUM(GA4_Web_Analytics[event_value_usd])

GA4 Events per User =
DIVIDE([GA4 Total Events], [GA4 Unique Users])
```

**Interpretation warning:** `unique_users` is distinct within each grouped row. The same pseudonymous user can occur in multiple dates, events, devices, countries or traffic media. Therefore, summing this field does not produce a deduplicated total of unique users for the full selected period. Label the card **Grouped Unique Users** and the ratio **Events per Grouped User**. Do not call this a site-wide unique-user count.

`event_value_usd` is the sum of the source `event_value_in_usd` field for all events in each group. It is not necessarily purchase revenue. Do not label it as revenue unless you separately filter and aggregate purchase events using a suitable purchase-revenue field.

## Limitations

The dataset is obfuscated and historical. Google notes limitations in internal consistency. Use it for learning query, aggregation and dashboard techniques, not for current commercial benchmarking. Keep this table separate from simulated campaign delivery data.

## Official reference

https://developers.google.com/analytics/bigquery/web-ecommerce-demo-dataset
