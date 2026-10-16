-- 03_join_listings_population.sql
-- Question: How do listings and population look side by side?
-- A JOIN lines up rows from two tables where the state name matches,
-- so both numbers sit in the same row and can be used in math.

SELECT listings_by_state.state,
       listings_by_state.listings,
       state_population.population
FROM listings_by_state
JOIN state_population ON listings_by_state.state = state_population.state
LIMIT 10;
