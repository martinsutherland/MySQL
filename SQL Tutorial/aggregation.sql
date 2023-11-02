-- SUM / COUNT

SELECT
  SUM(CASE WHEN country_id = 1 THEN 1 ELSE 0 END) AS England,
  SUM(CASE WHEN country_id = 2 THEN 1 ELSE 0 END) AS Scotland,
  COUNT(CASE WHEN country_id IN (1,2) THEN 1 ELSE NULL END) AS Other
FROM players;


-- MIN/MAX

SELECT 
    player_id,
    name,
    goals
FROM players 
WHERE goals = ( SELECT MIN(goals) FROM players );

SELECT MIN(goals) FROM players;

-- AVERAGE / ROUNDING

SELECT
    ROUND(AVG(appearances))
FROM players