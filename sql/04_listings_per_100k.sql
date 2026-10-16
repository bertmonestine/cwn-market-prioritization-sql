-- 04_listings_per_100k.sql
-- Question: Which states have the most listings for their size?
-- Dividing by population puts every state on the same scale:
-- listings per 100,000 residents.

SELECT listings_by_state.state,
       listings_by_state.listings,
       state_population.population,
       listings_by_state.listings * 100000.0 / state_population.population AS listings_per_100k
       -- 100000.0 (with .0) keeps decimals instead of rounding to whole numbers
FROM listings_by_state
JOIN state_population ON listings_by_state.state = state_population.state
ORDER BY listings_per_100k DESC
LIMIT 10;
