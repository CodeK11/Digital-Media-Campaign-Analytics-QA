# Power BI DAX measures

The actual PBIX uses these table names: `FactMediaDelivery`, `DimCampaign`, `DimDate`, `QA_IssueLog`, `QA_Summary` and `GA4_Web_Analytics`.

## Campaign delivery measures

```dax
Total Impressions = SUM(FactMediaDelivery[impressions])
Total Clicks = SUM(FactMediaDelivery[clicks])
Total Spend = SUM(FactMediaDelivery[media_cost_inr])
Total Conversions = SUM(FactMediaDelivery[conversions])
Total Revenue = SUM(FactMediaDelivery[attributed_revenue_inr])

CTR Measure = DIVIDE([Total Clicks], [Total Impressions])
CPC = DIVIDE([Total Spend], [Total Clicks])
CPM = DIVIDE([Total Spend] * 1000, [Total Impressions])
Conversion Rate = DIVIDE([Total Conversions], [Total Clicks])
CPA = DIVIDE([Total Spend], [Total Conversions])
ROAS Measure = DIVIDE([Total Revenue], [Total Spend])

Total QA Issues = COUNTROWS(QA_IssueLog)
Accepted Records = COUNTROWS(FactMediaDelivery)
Total Campaigns = DISTINCTCOUNT(DimCampaign[campaign_id])
```

The measure names `CTR Measure` and `ROAS Measure` avoid conflicts with imported columns named CTR and ROAS. Rates must be recalculated from aggregate numerators and denominators; do not average row-level rates.

## Campaign display column

```dax
Campaign Display =
DimCampaign[campaign_name]
    & " ("
    & DimCampaign[campaign_id]
    & ")"
```

## GA4 measures

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

**GA4 interpretation:** `GA4 Unique Users` is a sum of distinct-user counts calculated within each output group. It is not deduplicated across the full period and should be displayed as **Grouped Unique Users**. `GA4 Events per User` should be labelled **Events per Grouped User**. `GA4 Event Value USD` is not necessarily purchase revenue because the source query sums event value for all event types.

## Relationships

- `DimCampaign[campaign_id]` 1:* `FactMediaDelivery[campaign_id]`
- `DimDate[date]` 1:* `FactMediaDelivery[report_date]`
- `DimCampaign[campaign_id]` 1:* `QA_IssueLog[campaign_id]`
- `QA_Summary` is disconnected.
- `GA4_Web_Analytics` remains separate; do not join it to simulated paid-media delivery without a defensible attribution key.

Use single-direction filtering from dimensions to facts. Format spend/revenue/CPC/CPM/CPA as INR, CTR and Conversion Rate as percentages, ROAS as a decimal multiple, and event value as USD.
