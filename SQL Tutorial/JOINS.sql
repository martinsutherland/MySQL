-- INNER JOIN
-- This query JOINS 3 tables which displays 
-- player's name, team and country

SELECT * FROM players;
SELECT * FROM teams;
SELECT * FROM countries;

SELECT p.player_id, p.name, t.name AS team, c.name AS country FROM players p
INNER JOIN teams t
ON t.team_id = p.team_id
INNER JOIN countries c
ON c.country_id = p.country_id
ORDER BY t.name;

-- LEFT OUTER JOIN

SELECT * FROM players;
SELECT * FROM countries;

SELECT p.player_id, p.name, c.name AS country
FROM players p
LEFT JOIN countries c
ON p.country_id = c.country_id
ORDER BY player_id;

-- RIGHT OUTER JOIN

SELECT * FROM players;
SELECT * FROM countries;

SELECT p.player_id, p.name, c.name AS country
FROM players p
RIGHT JOIN countries c
ON p.country_id = c.country_id
ORDER BY player_id;

-- SELF JOIN

SELECT p1.player_id, p1.name, p2.name AS goat_name
FROM players p1
JOIN players p2 ON p1.GOAT = p2.player_id;

-- CROSS JOIN

SELECT p.player_id, p.name, c.name AS country
FROM players p
CROSS JOIN countries c
ORDER BY player_id;

