# Project build guide — what we did and why

## 1. Define the analyst workflow

Media analysts receive delivery reports from multiple platforms and must check completeness, consistency and metric logic before comparing performance. This project models report intake, QA, standardisation, KPI calculation, reconciliation and reporting.

## 2. Separate evidence types

The August 2026 agency-style delivery report is simulated practice data. It demonstrates paid-media delivery QA and KPI calculations, but it is not real client or platform data. Google's public GA4 sample is a separate historical web-analytics dataset. It does not contain the simulated campaign's spend or impressions. Keeping the sources separate prevents false attribution or performance claims.

## 3. Preserve raw intake

The original simulated intake file is retained unchanged. This supports traceability and allows each QA decision to be related to a source row.

## 4. Validate and standardise

The Python workflow checks dates, numeric fields, metric validity and campaign-day uniqueness. It standardises selected text fields and records QA issues. Rows failing core acceptance rules are excluded from the accepted fact table rather than silently repaired.

## 5. Calculate media KPIs

CTR, CPC, CPM, conversion rate, CPA and ROAS are derived from their component measures. Aggregate rates are recalculated from summed numerators and denominators, not by averaging daily rates.

## 6. Reconcile the database load

The cleaned CSV contained 173 rows. The initial MySQL wizard import loaded 172 rows without warnings. Python identified one missing record; it was inserted manually. The cause of the import omission was not established. After reconciliation, SQL checks returned 173 rows, including one zero-conversion row with NULL CPA.

## 7. Use Excel for operational reporting

The workbook contains Read Me, Raw Intake, QA Log, Clean Fact, KPI Summary, Campaign Summary and Dashboard tabs. It supports review of raw intake, issue dispositions, accepted records and weighted KPI summaries.

## 8. Use Python and SQL for repeatability

Python provides repeatable cleaning and validation. SQL demonstrates row-count, date-coverage, metric-integrity and campaign-summary checks. Expected outcomes are described in the SQL walkthrough.

## 9. Extract public GA4 web analytics

The BigQuery query aggregates the GA4 sample by event date, event name, device category, country and traffic medium. The exported CSV is loaded as a separate Power BI table. The grouped `unique_users` field is additive only as grouped counts; it is not a deduplicated total across the date range.

## 10. Power BI report architecture

The locally authored Power BI report contains four analytical pages:

1. Campaign Overview — core campaign KPIs, campaign spend and date filtering.
2. Channel & Campaign Analysis — channel spend, conversions and campaign/channel comparison.
3. Data Quality & Reconciliation — QA issue counts, issue register and source/database reconciliation.
4. GA4 Web Analytics — event counts, grouped user counts, event value, event-name/device breakdowns, daily trend and country/traffic-medium slicers.

Two drill-through pages support investigation:

5. Campaign Detail — reached from campaign visuals using `DimCampaign[Campaign Display]`.
6. QA Investigation — reached from QA/campaign visuals using `DimCampaign[Campaign Display]`.

The Campaign Detail and QA Investigation pages use campaign context. The GA4 table remains separate from the paid-media fact table; no unsupported campaign attribution relationship is created.

## 11. Document limitations

The simulated campaign data is not evidence of real campaign outcomes. The GA4 sample is historical and obfuscated. Event counts are not automatically sessions, orders or unique people. This is an educational portfolio project and does not claim professional media buying or activation experience.
