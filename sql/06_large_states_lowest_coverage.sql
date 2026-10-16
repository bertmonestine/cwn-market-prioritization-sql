-- 06_large_states_lowest_coverage.sql
-- Question: Among the biggest states, where does CWN have the fewest listings per resident?
-- WHERE filters rows before sorting: only states over 5 million residents.
-- ASC sorts lowest first, so the thinnest coverage appears at the top.

SELECT listings_by_state.state,
       state_population.population,
       listings_by_state.listings * 100000.0 / state_population.population AS listings_per_100k,
       ga4_users_by_state.active_users * 100000.0 / state_population.population AS users_per_100k
FROM listings_by_state
JOIN state_population ON listings_by_state.state = state_population.state
JOIN ga4_users_by_state ON listings_by_state.state = ga4_users_by_state.state
WHERE state_population.population > 5000000
ORDER BY listings_per_100k ASC
LIMIT 10;
