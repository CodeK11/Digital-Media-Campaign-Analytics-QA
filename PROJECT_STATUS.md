# Project status — 22 November 2026

## Campaign data and QA

- Simulated raw intake: 179 rows.
- Accepted cleaned fact: 173 rows.
- Excluded rows: 6.
- QA issue-log records: 8.
- Campaigns represented: 6.
- Reporting period: 1–31 August 2026.
- Python validation of the accepted fact table: 173 rows passed the listed date, completeness, metric and campaign-day uniqueness checks.
- SQL validation after reconciliation: 173 rows; 1 zero-conversion row; 1 NULL CPA row; no negative media cost or clicks-greater-than-impressions rows in the recorded checks.
- MySQL initial import loaded 172 rows; the missing record was identified and inserted manually. The precise cause of the initial import omission was not established.

## GA4 public-data extension

- BigQuery access test: successful.
- Aggregate extraction query: successful.
- Result CSV exported and saved locally by the user as `data/processed/ga4_web_analytics.csv`.
- Source: `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`.
- Date range: 1 November 2020–31 January 2021.
- Output grain: event date × event name × device category × country × traffic medium.
- Output fields: event date, event name, device category, country, traffic medium, event count, grouped distinct users and summed event value in USD.
- The exported CSV and native Power BI PBIX are local user-side artifacts and are not embedded in this portable documentation package.

## Power BI report

The user reports completing and validating the following four analytical pages:

1. Campaign Overview
2. Channel & Campaign Analysis
3. Data Quality & Reconciliation
4. GA4 Web Analytics

Two drill-through pages were also built:

5. Campaign Detail — drill-through by `DimCampaign[Campaign Display]`.
6. QA Investigation — drill-through by `DimCampaign[Campaign Display]`.

The native `.pbix` was authored locally in Power BI Desktop and must be retained by the user in the `powerbi/` folder. Confirm its final filename and include it in the GitHub repository if desired.

## Before GitHub publication

- Copy `ga4_web_analytics.csv` into `data/processed/`.
- Save the final `.pbix` under `powerbi/`.
- Add clear dashboard screenshots to `powerbi/screenshots/` (create the folder if needed).
- Reopen the PBIX after moving the project folder and verify that all source paths still resolve.
- Review the source and limitations statements in README before publishing.
