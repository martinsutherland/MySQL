DELIMITER //

CREATE PROCEDURE play_match(IN team1 INT, IN team2 INT)
BEGIN
-- Declare variables to hold the winner and loser team IDs
DECLARE winner INT;
DECLARE loser INT;

-- Set the value of the winner variable to the team ID of the team with the highest average number of goals scored per player among the two specified teams
SET winner = (
    SELECT t.team_id
    FROM players p
    INNER JOIN teams t ON p.team_id = t.team_id
    WHERE p.team_id IN (team1, team2) -- Only consider players from the specified teams
    GROUP BY t.team_id -- Group the results by team ID
    HAVING AVG(p.goals) = ( -- Select the team with the highest average number of goals scored per player
        SELECT MAX(avg_goals)
        FROM (
            SELECT AVG(goals) AS avg_goals
            FROM players
            WHERE team_id IN (team1, team2) -- Only consider players from the specified teams
            GROUP BY team_id
        ) AS team_avg_goals
    )
    
     -- Exclude teams with the lowest average number of goals scored per player
     AND AVG(p.goals) <> (
        SELECT MIN(avg_goals)
        FROM (
            SELECT AVG(goals) AS avg_goals
            FROM players
            WHERE team_id IN (team1, team2) -- Only consider players from the specified teams
            GROUP BY team_id
        ) AS team_avg_goals
    )
    
);


-- Set the value of the loser variable to the team ID of the team with the lowest average number of goals scored per player among the two specified teams, 
-- that is not tied for the highest average
  SET loser = (
    SELECT t.team_id
    FROM players p
    INNER JOIN teams t ON p.team_id = t.team_id
    WHERE p.team_id IN (team1, team2)
    GROUP BY t.team_id 
    HAVING AVG(p.goals) = ( 
        SELECT MIN(avg_goals)
        FROM (
            SELECT AVG(goals) AS avg_goals
            FROM players
            WHERE team_id IN (team1, team2) 
            GROUP BY team_id
        ) AS team_avg_goals
    )
    
    
     AND AVG(p.goals) <> (
        SELECT MAX(avg_goals)
        FROM (
            SELECT AVG(goals) AS avg_goals
            FROM players
            WHERE team_id IN (team1, team2) 
            GROUP BY team_id
        ) AS team_avg_goals
    )
    
);
-- Returns the winning team if the variable 'winner' is NOT NULL
IF winner IS NOT NULL THEN
    SELECT team_id, name AS winner
    FROM teams WHERE team_id = winner;
END IF;

-- Returns the losing team if the variable 'loser' is NOT NULL, otherwise it returns both team and 'Draw' as the result
IF winner IS NULL AND loser IS NULL THEN
    SELECT team_id, name AS winner, 'Draw' AS result
    FROM teams WHERE team_id IN (team1, team2);
END IF;

END
//

DELIMITER ;