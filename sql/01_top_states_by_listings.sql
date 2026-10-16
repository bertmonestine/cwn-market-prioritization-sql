-- 01_top_states_by_listings.sql
-- Question: Which 10 states have the most CWN directory listings?
-- Table used: listings_by_state (one row per state, with its listing count)

SELECT state, listings
FROM listings_by_state
ORDER BY listings DESC   -- biggest count first
LIMIT 10;                -- keep only the top 10 rows
