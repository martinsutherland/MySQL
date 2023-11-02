-- PIVOT table arranging all competition winners into a readable dataset
SELECT * FROM winners;

SELECT
  name AS team_name,
  SUM(CASE WHEN trophy = 'Premier League' THEN 1 ELSE 0 END) AS EPL,
  SUM(CASE WHEN trophy = 'FA Cup' THEN 1 ELSE 0 END) AS FA_Cup,
  SUM(CASE WHEN trophy = 'League Cup' THEN 1 ELSE 0 END) AS League_Cup,
  SUM(CASE WHEN trophy IN ('Premier League', 'FA Cup', 'League Cup') THEN 1 ELSE 0 END) AS Total
FROM winners
GROUP BY team_name
ORDER BY Total DESC;

SELECT
  name AS team_name,
  SUM(CASE WHEN trophy = 'Premier League' THEN 1 ELSE 0 END) AS EPL,
  SUM(CASE WHEN trophy = 'FA Cup' THEN 1 ELSE 0 END) AS FA_Cup,
  SUM(CASE WHEN trophy = 'League Cup' THEN 1 ELSE 0 END) AS League_Cup,
  SUM(CASE WHEN trophy IN ('Premier League', 'FA Cup', 'League Cup') THEN 1 ELSE 0 END) AS Total
FROM winners
GROUP BY team_name
HAVING Total > 12
ORDER BY Total DESC;