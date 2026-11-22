# Essential file inventory

- `README.md` — project overview, reproducibility and data-integrity caveats.
- `PROJECT_STATUS.md` — completed workflow, validation results and remaining local publication steps.
- `excel/Media_Campaign_Analytics_QA_Workbook.xlsx` — primary Excel deliverable.
- `data/raw/simulated_agency_reports/agency_delivery_report_aug_2026.csv` — immutable simulated source intake.
- `data/processed/fact_media_delivery_demo.csv` — accepted simulated campaign rows with derived metrics.
- `data/processed/qa_issue_log_demo.csv` — simulated QA issue log.
- `data/processed/dim_campaign_demo.csv`, `dim_date_demo.csv` — Power BI dimensions.
- `data/processed/ga4_web_analytics.csv` — exported GA4 aggregate CSV; created locally by the user and must be copied into this folder before GitHub publication.
- `outputs/qa_summary_demo.csv` — QA summary.
- `sql/ga4_public_dataset_extract.sql` — exact BigQuery extraction query used for the GA4 page.
- `sql/validation_queries.sql` — SQL validation examples.
- `src/clean_validate_media_data.py` — reproducible Python cleaning and validation.
- `powerbi/DAX_MEASURES.md` — campaign and GA4 DAX measures.
- `powerbi/POWER_BI_BUILD_GUIDE.md` — actual six-page Power BI build structure and navigation notes.
- `powerbi/Media_Analytics_Theme.json` — report theme.
- `powerbi/Digital_Media_Campaign_Analytics.pbix` — native PBIX created locally; retain/copy it into this folder before GitHub publication.
- `powerbi/screenshots/` — recommended folder for final report-page screenshots.
- `docs/` — source register, data dictionary, methodology, extraction guide, project build guide and this inventory.
- `reports/ANALYST_REPORT_TEMPLATE.md` — analyst report structure.

The GA4 export and PBIX are local user-side deliverables and are not embedded in this documentation ZIP. Do not confuse the processed simulated campaign CSVs with the GA4 export.
