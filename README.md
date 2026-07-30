# Bright TV – Customer Value Management (CVM) Analysis

## Overview

Bright TV's CEO has set an objective to grow the company's subscription base for the current financial year. This project analyses historical customer profile and playback event data to give the Customer Value Management (CVM) team actionable insight into subscriber behaviour and opportunities for growth.

## Objective

Using the historical dataset, this project answers:

- What are the key user and usage trends on the Bright TV platform?
- What factors influence content consumption?
- What content should be introduced or rescheduled to lift consumption on low-activity days/times?
- What initiatives would grow Bright TV's overall user base?

## Data

**Source:** Customer database and playback events data.

**Size:** 16 columns, 9,934 rows.

**Key fields:** `sub_id`, `watch_time`, `day_classification`, `channel_description`, `time_of_day`, `screen_time_bucket`, `duration`, `age_groups`.

## Summary Statistics

| Metric | Value |
|---|---|
| Total active sessions | 9,934 |
| Active users | 4,375 |
| Total hours watched | 1,522 |

*Figures exclude technical downtime.*

## Methodology

1. **Data preparation** – Cleaned and consolidated customer profile and playback event records into a single analysis-ready dataset; classified sessions by province, gender, time of day, and screen-time bucket.
2. **Exploratory analysis** – Aggregated sessions by province, gender, time of day, screen time, and month to identify usage patterns.
3. **Insight synthesis** – Interpreted the aggregated data to identify drivers of consumption and gaps in engagement.
4. **Recommendations** – Translated insights into concrete CVM actions covering content, scheduling, and marketing.

## Key Insights

- **Regional concentration:** Gauteng (~3,700 sessions), Western Cape (~1,800), and KwaZulu-Natal (~1,000) drive the majority of viewing sessions.
- **Gender skew:** Male viewers account for 87% of sessions vs. 10% female and 3% unclassified.
- **Time of day:** Mornings and afternoons are primetime (~3,800 sessions each); night sessions drop to ~700.
- **Screen time:** Most sessions are under 30 minutes; medium/high-usage sessions (30–60+ min) total only ~800 combined.
- **Growth trend:** Monthly sessions more than doubled from ~2,100 in January to ~4,900 in March.

## Recommendations

- **Fix onboarding UX:** Audit app load times and player latency to reduce early drop-off.
- **Prime-time shift:** Reschedule flagship programmes into evening hours while keeping daytime playlists for current casual viewers.
- **Expand audience:** Introduce female-targeted content and marketing to close the gender gap.
- **Target key regions:** Focus acquisition marketing on Gauteng, Western Cape, and KwaZulu-Natal metro markets.

## Tools Used

| Category | Tool |
|---|---|
| Project Planning | Miro|
| Data Processing | Databricks & Microsoft Excel_ |
| Data Visualization | Microsoft Excel / Power BI |
| Presentation | Microsoft PowerPoint |
| Documentation | Microsoft Word |
