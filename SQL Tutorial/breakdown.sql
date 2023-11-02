
-- Firstly, there are two variables decalred that will be used for the ID of th winner and loser

-- The query first performs an inner join on the "players" and "teams" tables using the "team_id" column to match records from both tables:

SELECT t.team_id
FROM players p
INNER JOIN teams t ON p.team_id = t.team_id

-- This join combines the "team_id" values from both tables to retrieve the corresponding "team_id" from the "teams" table for each "team_id" in the "players" table.

-- The WHERE clause filters the results to only include teams that match the "team1" and "team2" values:

WHERE p.team_id IN (team1, team2)

-- The GROUP BY clause groups the results by the "team_id" column from the "teams" table:

GROUP BY t.team_id

-- This allows the query to calculate the average goals scored per player for each team.

-- The HAVING clause filters the grouped results based on the criteria that the average goals scored per player is equal to the maximum average goals scored per player:

HAVING AVG(p.goals) = (
    SELECT MAX(avg_goals)
    FROM (
        SELECT AVG(goals) AS avg_goals
        FROM players
        WHERE team_id IN (team1, team2)
        GROUP BY team_id
    ) AS team_avg_goals
)

-- and is not equal to the minimum average goals scored per player:

AVG(p.goals) <> (
    SELECT MIN(avg_goals)
    FROM (
        SELECT AVG(goals) AS avg_goals
        FROM players
        WHERE team_id IN (team1, team2)
        GROUP BY team_id
    ) AS team_avg_goals
)


-- Overall, this query returns the team ID(s) that have the highest average goals scored per player among the teams specified as team1 and team2, excluding teams with the lowest average goals scored per player.


