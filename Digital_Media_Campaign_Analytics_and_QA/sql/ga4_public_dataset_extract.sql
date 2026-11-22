-- Project: Digital Media Campaign Analytics & QA
-- Exact aggregate query used for the GA4 Web Analytics Power BI page.
-- Source: bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*
-- Date range: 2020-11-01 to 2021-01-31
-- Output grain: event_date x event_name x device_category x country x traffic_medium
-- Run in BigQuery UI and export Query results as CSV.
-- This is historical, obfuscated web-event data, NOT paid-media delivery data.

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

-- Interpretation notes:
-- 1. unique_users is distinct within each output group. Summing across groups can
--    count the same pseudonymous user more than once; it is not a period-wide
--    deduplicated unique-user total.
-- 2. event_value_usd sums event_value_in_usd for all events in each group. It is
--    not necessarily purchase revenue.
-- 3. Keep this GA4 table separate from simulated campaign-delivery data.
