-- SET winner trying to determine the winner of a match between two teams, given the IDs of the two teams. 
-- The winner is determined by comparing the average number of goals scored per player on each team. 
-- The team with the highest average is declared the winner, as long as it is not tied with the team with the lowest average. 
-- If the two teams have the same average number of goals scored per player, the winner is not determined and the winner variable will be set to NULL.

-- SET loser is trying to determine the loser of a match between two teams, given the IDs of the two teams. 
-- The loser is determined by comparing the average number of goals scored per player on each team. 
-- The team with the lowest average is declared the loser, as long as it is not tied with the team with the highest average. 
-- If the two teams have the same average number of goals scored per player, the loser is not determined and the loser variable will be set to NULL.

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


IF winner IS NOT NULL THEN
    -- update the winner's properties
    UPDATE teams SET played = played + 1, won = won + 1, points = points + 3 WHERE team_id = winner;
END IF;

IF loser IS NOT NULL THEN
    -- update the loser's properties
    UPDATE teams SET played = played + 1, lost = lost + 1 WHERE team_id = loser;
END IF;

IF winner IS NULL AND loser IS NULL THEN
    -- update both team's properties for a draw
    UPDATE teams SET played = played + 1, draw = draw + 1, points = points + 1 WHERE team_id IN (team1, team2);
END IF;

END
//

DELIMITER ;