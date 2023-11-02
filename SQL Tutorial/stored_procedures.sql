-- procedure to update the properties of teams involved in a match

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


-- Set the value of the loser variable to the team ID of the team with the lowest average number of goals scored per player among the two specified teams, that is not tied for the highest average
SET loser = (
    SELECT t.team_id
    FROM players p
    INNER JOIN teams t ON p.team_id = t.team_id
    WHERE p.team_id IN (team1, team2) -- Only consider players from the specified teams
    GROUP BY t.team_id -- Group the results by team ID
    HAVING AVG(p.goals) = ( -- Select the team with the lowest average number of goals scored per player
        SELECT MIN(avg_goals)
        FROM (
            SELECT AVG(goals) AS avg_goals
            FROM players
            WHERE team_id IN (team1, team2) -- Only consider players from the specified teams
            GROUP BY team_id
        ) AS team_avg_goals
    ) AND t.team_id NOT IN ( -- Exclude teams with the highest average number of goals scored per player
        SELECT t2.team_id
        FROM players p2
        INNER JOIN teams t2 ON p2.team_id = t2.team_id
        WHERE p2.team_id IN (team1, team2) -- Only consider players from the specified teams
        GROUP BY t2.team_id -- Group the results by team ID
        HAVING AVG(p2.goals) = ( -- Select the team with the highest average number of goals scored per player
            SELECT MAX(avg_goals)
            FROM (
                SELECT AVG(goals) AS avg_goals
                FROM players
                WHERE team_id IN (team1, team2) -- Only consider players from the specified teams
                GROUP BY team_id
            ) AS team_avg_goals
        )
    )
    LIMIT 1 -- Only return one result (the first row)
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

-- resting data to default values
DELIMITER //

CREATE PROCEDURE reset_team_data()
BEGIN
 UPDATE teams
SET played = 0, won = 0, draw = 0, lost = 0, points = 0;
END
DELIMITER ;

-- This code is defining a MySQL stored procedure named update_all_team_properties() that updates team properties for all combinations of teams in a table called teams.

-- The procedure starts by defining several variables: done is a flag variable that is initially set to FALSE, team1_id and team2_id are variables 
-- that will hold the team IDs from the teams table, and two cursors named team_cursor and team2_cursor are defined. 
-- The team_cursor cursor selects all team IDs from the teams table, and the team2_cursor cursor selects all team IDs from the teams table again.

-- Next, a CONTINUE HANDLER is defined to catch the NOT FOUND error that is raised when there are no more rows to fetch from a cursor.

-- The reset_team_data() procedure is called, which likely resets some team properties to their default values.

-- The team_cursor is then opened, and a loop is started with a LOOP statement. The FETCH statement is used to retrieve the next row from the team_cursor and store the team ID in the team1_id variable. If there are no more rows to fetch, the done flag is set to TRUE and the loop is exited with a LEAVE statement.

-- Inside the team_loop, the team2_cursor is opened, and a loop is started with another LOOP statement. The FETCH statement retrieves the next row from the team2_cursor and stores the team ID in the team2_id variable. If there are no more rows to fetch, the done flag is set to TRUE and the loop is exited with another LEAVE statement.

-- If the team1_id is not equal to team2_id, then the update_team_properties() procedure is called with the team1_id and team2_id as arguments. This likely updates some team properties based on the combination of the two teams.

-- The team2_cursor is then closed, and the done flag is set to FALSE to continue iterating over the team_cursor loop.

-- After all combinations of teams have been processed, the team_cursor is closed and the procedure is complete.

-- Overall, this procedure is designed to update team properties for all combinations of teams in a table. It uses two cursors to iterate over the teams table and call another stored procedure to update team properties based on combinations of teams.

DELIMITER //

CREATE PROCEDURE update_all_team_properties()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE team1_id, team2_id INT;
    DECLARE team_cursor CURSOR FOR SELECT team_id FROM teams;
    DECLARE team2_cursor CURSOR FOR SELECT team_id FROM teams;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    CALL reset_all_teams();

    OPEN team_cursor;
    team_loop: LOOP
        FETCH team_cursor INTO team1_id;
        IF done THEN
            LEAVE team_loop;
        END IF;

        OPEN team2_cursor;
        team2_loop: LOOP
            FETCH team2_cursor INTO team2_id;
            IF done THEN
                LEAVE team2_loop;
            END IF;

            IF team1_id <> team2_id THEN
                CALL play_match(team1_id, team2_id);
            END IF;
        END LOOP team2_loop;
        CLOSE team2_cursor;
        SET done = FALSE;
    END LOOP team_loop;
    CLOSE team_cursor;
END

DELIMITER ;