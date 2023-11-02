
DELIMITER //


CREATE PROCEDURE play_all_matches()
BEGIN
    -- Declare variables to control the flow of the procedure
    DECLARE done INT DEFAULT FALSE;
    DECLARE team1_id, team2_id INT;

    -- Declare cursors to iterate over the teams
    DECLARE team_cursor CURSOR FOR SELECT team_id FROM teams;
    DECLARE team2_cursor CURSOR FOR SELECT team_id FROM teams;

    -- Declare a handler to catch the NOT FOUND condition
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Call the reset_all_teams() procedure to clear all team statistics before updating them
    CALL reset_all_teams();

    -- Open the team_cursor to start iterating over teams
    OPEN team_cursor;
    team_loop: LOOP
        -- Fetch the next team_id from the team_cursor
        --    FETCH command will get the next row of data from the team_cursor cursor, and store the value of the team_id column in the team1_id variable.
        FETCH team_cursor INTO team1_id;

        -- If there are no more teams, set done to TRUE and leave the team_loop
        IF done THEN
            LEAVE team_loop;
        END IF;

        -- Open the team2_cursor to start iterating over teams again
        OPEN team2_cursor;
        team2_loop: LOOP
            -- Fetch the next team_id from the team2_cursor
        --    FETCH command will get the next row of data from the team2_cursor cursor, and store the value of the team_id column in the team2_id variable.
            FETCH team2_cursor INTO team2_id;

            -- If there are no more teams, set done to TRUE and leave the team2_loop
            IF done THEN
                LEAVE team2_loop;
            END IF;

            -- If the two team_ids are not equal, call the play_match procedure to simulate a match between them
            IF team1_id <> team2_id THEN
                CALL play_match(team1_id, team2_id);
            END IF;
        END LOOP team2_loop;

        -- Close the team2_cursor
        CLOSE team2_cursor;

        -- Reset the done variable to FALSE for the next iteration of the team_loop
        SET done = FALSE;
    END LOOP team_loop;

    -- Close the team_cursor
    CLOSE team_cursor;
END

-- Reset the delimiter to the default semicolon
DELIMITER ;
