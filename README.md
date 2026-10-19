# CWN Market Prioritization (SQL)

**Question:** Which U.S. states should CrossingWatersNetwork.org prioritize for new listings, blog content and ad spend?

**Contents:** [Data](#data) · [Method](#method) · [Results](#results) · [Limits and notes](#limits-and-notes)

This project uses SQL (SQLite) to compare three things for every state: how many facilities the CWN directory covers, how many people live there, and how much site traffic comes from there. The result is a ranking of coverage gaps that can guide budget allocation.

## Data

All files are in `data/`.

| File | What it is | Source |
|---|---|---|
| `listings_by_state.csv` | Number of CWN directory listings per state (13,745 total; 50 states plus DC) | Counted from the site's GeoDirectory export. The full export is not included. |
| `ga4_users_by_state.csv` | Google Analytics 4 active users per state, Jul 1 – Oct 11, 2026 | GA4 Demographic details report (Region), filtered to the 50 states plus DC. States with no recorded users are set to 0. |
| `state_population.csv` | Resident population per state, July 1, 2024 | [U.S. Census Bureau, Vintage 2024 population estimates](https://www.census.gov/data/tables/time-series/demo/popest/2020s-state-total.html) |

**Definition of a listing:** one facility page published in the CWN directory. The numbers measure CWN's own coverage, not the total number of treatment facilities in a state.

## Method

The queries are in `sql/` and are numbered in the order they were built. Each one is commented.

| Query | What it answers |
|---|---|
| `01_top_states_by_listings.sql` | Which states have the most listings |
| `02_top_states_by_traffic.sql` | Which states send the most visitors |
| `03_join_listings_population.sql` | Joins listings and population in one table |
| `04_listings_per_100k.sql` | Listings per 100,000 residents |
| `05_listings_and_traffic_per_100k.sql` | Adds visitors per 100,000 residents (second join) |
| `06_large_states_lowest_coverage.sql` | Large states (over 5 million) with the lowest coverage |
| `07_national_average.sql` | National average of listings per 100,000 residents (about 4.04) |
| `08_opportunity_ranking.sql` | Final ranking of coverage gaps |

**Opportunity ranking (query 08):**
- `listings_short` = the listings a state would have at the national average, minus the listings it actually has. A positive number means the state is under-covered.
- `opportunity_score` = `listings_short` divided by (1 + visitors per 100,000 residents), so states that already get traffic score slightly lower.

To reproduce: load the three CSV files into SQLite (for example with DB Browser for SQLite) as tables named `listings_by_state`, `state_population` and `ga4_users_by_state`, then run the queries in order.

## Results

Largest coverage gaps (full top 15 in `results/08_opportunity_ranking.csv`):

| State | Population | Listings | Listings short of national average | Opportunity score |
|---|---|---|---|---|
| Texas | 31,290,831 | 447 | 817 | 801.8 |
| California | 39,431,263 | 1,159 | 434 | 416.1 |
| Florida | 23,372,215 | 631 | 313 | 299.2 |
| Georgia | 11,180,878 | 229 | 223 | 211.4 |
| South Carolina | 5,478,831 | 100 | 121 | 117.1 |

Other findings:
- By raw count, California (1,159), New York (886) and Ohio (725) have the most listings.
- Per 100,000 residents, Alaska (12.6), Utah (10.6) and Idaho (10.4) have the strongest coverage.
- Among states with more than 5 million residents, Texas has the lowest coverage at 1.4 listings per 100,000 residents, against a national average of about 4.0.

**Suggested use:** prioritize Texas, California and Florida for additional listings, local content and paid campaigns, since they combine large populations with below-average coverage and very little traffic.

## Limits and notes

- **Small traffic sample.** Most states recorded only 1 to 5 active users over the period, so traffic differences between states are not statistically reliable. Because of this, population drives most of the opportunity score.
- **Iowa is an outlier.** Iowa recorded 70 active users, far above any other state. The cause is unknown, and it may not reflect real audience interest.
- **Coverage is not the same as supply.** A low listings-per-resident figure shows a gap in CWN's directory. It does not prove that listings are missing. The data source, filtering or the number of facilities in a state could also explain it. Before spending in Texas, compare the state's listings against an official facility list.
- **Users, not sessions.** GA4's region report counts active users, and this analysis uses that metric.
- **The national average is a yardstick, not a target.** States above it are not necessarily over-served.
- **Directional only.** The ranking shows where to look first. It does not predict return on spend.
