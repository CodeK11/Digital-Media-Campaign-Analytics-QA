from pathlib import Path
import pandas as pd
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "data/raw/simulated_agency_reports/agency_delivery_report_aug_2026.csv"
OUT = ROOT / "data/processed"
OUT.mkdir(parents=True, exist_ok=True)

df = pd.read_csv(SOURCE)
df["report_date"] = pd.to_datetime(df["report_date"], format="%Y-%m-%d", errors="coerce")
df["campaign_name"] = df["campaign_name"].astype("string").str.strip()
df["platform"] = df["platform"].fillna("UNKNOWN_REVIEW")
numeric = ["impressions", "clicks", "media_cost_inr", "conversions", "attributed_revenue_inr"]
for col in numeric:
    df[col] = pd.to_numeric(df[col], errors="coerce")

duplicate = df.duplicated(subset=["report_date", "campaign_id"], keep="first")
checks = {
    "date_valid_iso": df["report_date"].notna(),
    "impressions_present": df["impressions"].notna() & (df["impressions"] >= 0),
    "clicks_valid": df["clicks"].notna() & (df["clicks"] >= 0) & (df["clicks"] <= df["impressions"]),
    "cost_valid": df["media_cost_inr"].notna() & (df["media_cost_inr"] >= 0),
    "conversions_valid": df["conversions"].notna() & (df["conversions"] >= 0),
    "revenue_valid": df["attributed_revenue_inr"].notna() & (df["attributed_revenue_inr"] >= 0),
    "unique_campaign_day": ~duplicate,
}
for name, passed in checks.items():
    print(f"{name}: {int(passed.sum())}/{len(df)} passed")

valid_mask = pd.Series(True, index=df.index)
for passed in checks.values():
    valid_mask &= passed

clean = df.loc[valid_mask].copy()
clean = clean.dropna(subset=numeric)
clean["report_date"] = clean["report_date"].dt.strftime("%Y-%m-%d")
clean["ctr"] = np.where(clean.impressions > 0, clean.clicks / clean.impressions, np.nan)
clean["cpc_inr"] = np.where(clean.clicks > 0, clean.media_cost_inr / clean.clicks, np.nan)
clean["cpm_inr"] = np.where(clean.impressions > 0, clean.media_cost_inr / clean.impressions * 1000, np.nan)
clean["conversion_rate"] = np.where(clean.clicks > 0, clean.conversions / clean.clicks, np.nan)
clean["cpa_inr"] = np.where(clean.conversions > 0, clean.media_cost_inr / clean.conversions, np.nan)
clean["roas"] = np.where(clean.media_cost_inr > 0, clean.attributed_revenue_inr / clean.media_cost_inr, np.nan)
clean.to_csv(OUT / "fact_media_delivery_demo.csv", index=False)
print(f"Accepted rows: {len(clean)}; excluded rows: {len(df)-len(clean)}")
