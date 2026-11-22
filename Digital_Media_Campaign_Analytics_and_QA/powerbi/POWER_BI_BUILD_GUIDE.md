# Power BI build guide — completed report structure

The locally authored report uses Power BI Desktop and the table names below. The PBIX is a local native Power BI file; this guide does not replace it.

## Data model

Imported tables:

- `FactMediaDelivery` — 173 accepted simulated campaign-delivery rows.
- `DimCampaign` — six unique campaign IDs; `Campaign Display` is campaign name plus campaign ID.
- `DimDate` — date dimension.
- `QA_IssueLog` — eight QA issue records.
- `QA_Summary` — disconnected QA summary table.
- `GA4_Web_Analytics` — exported public GA4 aggregate data.

Relationships:

- `DimCampaign[campaign_id]` → `FactMediaDelivery[campaign_id]` (1:*, single direction).
- `DimDate[date]` → `FactMediaDelivery[report_date]` (1:*, single direction).
- `DimCampaign[campaign_id]` → `QA_IssueLog[campaign_id]` (1:*, single direction).
- `QA_Summary` disconnected.
- `GA4_Web_Analytics` separate from campaign-delivery facts.

## Analytical pages

### Page 1 — Campaign Overview

- Six KPI cards: Total Spend, Total Impressions, Total Clicks, CTR Measure, Total Conversions, ROAS Measure.
- Spend by Campaign bar chart using `DimCampaign[Campaign Display]` so all six campaign IDs remain distinct even where campaign names repeat.
- Date slicer using `DimDate[date]`.

### Page 2 — Channel & Campaign Analysis

- Media Spend by Channel clustered column chart.
- Conversions by Channel clustered column chart.
- Campaign/channel performance table with spend, clicks, CTR, conversions and ROAS.
- Channel dropdown slicer.

### Page 3 — Data Quality & Reconciliation

- KPI cards: Total QA Issues, Accepted Records, Total Campaigns and QA Log Records.
- QA Issues by Category chart.
- QA Issue Register table.
- QA Issues by Campaign chart.
- Campaign dropdown slicer.
- Reconciliation note: processed CSV 173 rows; MySQL after reconciliation 173; zero-conversion rows 1; NULL CPA rows 1; recorded SQL/Python validation failures 0. The initial import loaded 172 rows; the missing row was found and inserted manually; root cause not established.

### Page 4 — GA4 Web Analytics

- KPI cards: GA4 Total Events, Grouped Unique Users, GA4 Event Value USD and Events per Grouped User.
- Events by Event Name bar chart.
- Events by Device Category donut chart.
- Daily Event Trend line chart using `Event Date`.
- Country and Traffic Medium dropdown slicers.
- This page represents historical, obfuscated public GA4 web-event data, not paid-media delivery.

## Drill-through pages

### Page 5 — Campaign Detail

- Page type: Drillthrough.
- Drill-through field: `DimCampaign[Campaign Display]`.
- Keep all filters: On.
- KPI cards: Total Spend, Total Impressions, Total Clicks and Total Conversions.
- Campaign performance table and daily spend trend.
- Back button.

### Page 6 — QA Investigation

- Page type: Drillthrough.
- Drill-through field: `DimCampaign[Campaign Display]`.
- Keep all filters: On.
- QA issue register using `campaign_id`, source row number, `issue_codes` and `disposition`.
- Total QA Issues card, issue-type chart and disposition slicer.
- Back button.

## Final checks

- Save the PBIX after refresh and after moving the project folder.
- Verify source paths for all CSVs, especially `data/processed/ga4_web_analytics.csv`.
- Test date, channel, country and traffic-medium slicers.
- Test both drill-through pages from their originating visuals and test Back buttons.
- Verify that campaign and GA4 pages remain separate in interpretation.
