-- 07_national_average.sql
-- Question: What is the national average of listings per 100,000 residents?
-- This is the yardstick used in query 08 to measure each state's coverage gap.
-- SUM() adds up a whole column; the result is a single number (about 4.04).

SELECT SUM(listings_by_state.listings) * 100000.0 / SUM(state_population.population) AS national_listings_per_100k
FROM listings_by_state
JOIN state_population ON listings_by_state.state = state_population.state;
