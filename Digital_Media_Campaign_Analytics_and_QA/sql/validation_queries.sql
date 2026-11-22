-- SQLite / MySQL-compatible validation examples for fact_media_delivery_demo.csv
-- Load the CSV as a table named fact_media_delivery_demo before running.

-- 1. Row count and date coverage
SELECT COUNT(*) AS rows_loaded,
       MIN(report_date) AS first_date,
       MAX(report_date) AS last_date
FROM fact_media_delivery_demo;

-- Expected: one row per accepted simulated campaign-day record; dates in August 2026.

-- 2. Hard-rule check: clicks must not exceed impressions
SELECT COUNT(*) AS invalid_click_rows
FROM fact_media_delivery_demo
WHERE clicks > impressions;

-- Expected: 0. Actual results should be checked against your imported table.

-- 3. Non-negative cost check
SELECT COUNT(*) AS negative_cost_rows
FROM fact_media_delivery_demo
WHERE media_cost_inr < 0;

-- Expected: 0. Actual results should be checked against your imported table.

-- 4. Campaign summary
SELECT campaign_id,
       SUM(impressions) AS impressions,
       SUM(clicks) AS clicks,
       SUM(media_cost_inr) AS spend_inr,
       SUM(conversions) AS conversions,
       SUM(attributed_revenue_inr) AS attributed_revenue_inr
FROM fact_media_delivery_demo
GROUP BY campaign_id
ORDER BY spend_inr DESC;

-- Expected: one row per campaign_id, ordered by total spend descending.
