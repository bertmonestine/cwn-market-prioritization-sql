-- 02_top_states_by_traffic.sql
-- Question: Which 10 states send the most visitors to the site?
-- Table used: ga4_users_by_state (GA4 active users by state, Jul 1 - Oct 11, 2026)
-- States with no recorded visitors are stored as 0.

SELECT state, active_users
FROM ga4_users_by_state
ORDER BY active_users DESC
LIMIT 10;
