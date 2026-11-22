# Methodology and analytical controls

## Simulated campaign-delivery workflow

1. Preserve the source intake file unchanged.
2. Parse dates using explicit date conversion; invalid dates are flagged.
3. Trim campaign-name whitespace and preserve a traceable QA issue log.
4. Convert metric fields to numeric types; missing or invalid values are not silently imputed.
5. Enforce hard rules: non-negative metrics and clicks <= impressions.
6. Exclude rows failing core validity checks from the accepted fact table; retain issue codes in the QA log.
7. Calculate CTR, CPC, CPM, conversion rate, CPA and ROAS only where denominators are valid.
8. Aggregate metrics from summed numerators and denominators. Do not average row-level rates when producing campaign totals.
9. Reconcile row counts across CSV and database. In this project the CSV contained 173 accepted rows; the first MySQL import loaded 172, and the missing record was identified and inserted manually. The root cause of the import omission was not determined.

## GA4 public-data workflow

10. Query the public `ga4_obfuscated_sample_ecommerce.events_*` tables for 2020-11-01 through 2021-01-31.
11. Aggregate by event date, event name, device category, country and traffic medium.
12. Count events and distinct pseudonymous users within each output group; sum the source event-value field.
13. Convert `YYYYMMDD` event dates to a Date column in Power Query while retaining the original text field.
14. Keep GA4 web analytics separate from the simulated paid-media delivery data.

## Interpretation controls

- The GA4 `unique_users` field is distinct within each grouped row. Summing it across groups can count the same pseudonymous user multiple times. Do not describe the sum as total unique users for the entire period.
- `event_value_usd` is the sum of `event_value_in_usd` across all events in the group; it is not necessarily purchase revenue.
- GA4 event counts are not necessarily sessions, orders or unique people.
- The GA4 sample is historical, obfuscated and subject to source limitations.
- Simulated media delivery records must never be described as actual client or platform results.
