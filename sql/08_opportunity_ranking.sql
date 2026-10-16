-- 08_opportunity_ranking.sql
-- Question: Which states are the biggest opportunities for new listings, content and ad spend?
--
-- Method:
--   listings_short    = listings the state would have at the national average (4.04 per 100K)
--                       minus the listings it actually has. Positive = under-covered.
--   users_per_100k    = site visitors per 100,000 residents (traffic already coming in).
--   opportunity_score = listings_short divided by (1 + users_per_100k), so states that
--                       already get traffic score a little lower.
-- Population drives most of the score; traffic is thin everywhere (see README limits).
-- The 4.04 comes from query 07. Update it there first if the data changes.

SELECT listings_by_state.state,
       state_population.population,
       listings_by_state.listings,
       ROUND(4.04 * state_population.population / 100000.0 - listings_by_state.listings) AS listings_short,
       ROUND(ga4_users_by_state.active_users * 100000.0 / state_population.population, 2) AS users_per_100k,
       ROUND((4.04 * state_population.population / 100000.0 - listings_by_state.listings)
             / (1 + ga4_users_by_state.active_users * 100000.0 / state_population.population), 1) AS opportunity_score
FROM listings_by_state
JOIN state_population ON listings_by_state.state = state_population.state
JOIN ga4_users_by_state ON listings_by_state.state = ga4_users_by_state.state
ORDER BY opportunity_score DESC
LIMIT 15;
