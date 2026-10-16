-- 05_listings_and_traffic_per_100k.sql
-- Question: How do coverage and traffic compare once population is accounted for?
-- Adds a second JOIN for the traffic table, then computes visitors per 100,000 residents.

SELECT listings_by_state.state,
       listings_by_state.listings * 100000.0 / state_population.population AS listings_per_100k,
       ga4_users_by_state.active_users * 100000.0 / state_population.population AS users_per_100k
FROM listings_by_state
JOIN state_population ON listings_by_state.state = state_population.state
JOIN ga4_users_by_state ON listings_by_state.state = ga4_users_by_state.state
ORDER BY users_per_100k DESC
LIMIT 10;
