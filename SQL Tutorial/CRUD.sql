-- We perform the CRUD operations
--  Create, Read, Update, Delete

SELECT * FROM teams;

-- CREATE
INSERT INTO teams(name, founded, country_id)
VALUES('Celtic', '1888', 2);

INSERT INTO teams(name, founded, country_id)
VALUES('Aberdeen', '1904', 2);

-- READ
SELECT * FROM teams;

-- UPDATE
UPDATE teams
SET name = 'Celtic FC'
WHERE name = 'Celtic';

UPDATE teams
SET founded = '1903'
WHERE team_id = ;

UPDATE teams
SET name = CONCAT(name, ' (SCO)')
WHERE country_id = 2;

SELECT * FROM teams
WHERE country_id = 2;

-- DELETE
DELETE FROM teams
WHERE name = 'Celtic FC (SCO)';

DELETE FROM teams
WHERE team_id = 33;
