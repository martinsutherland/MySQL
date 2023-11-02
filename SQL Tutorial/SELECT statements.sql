SELECT * FROM players;

SELECT name, appearances, goals 
FROM players;

SELECT name AS footballer, appearances, goals 
FROM players;

SELECT * 
FROM players
WHERE goals > 200;

-- starts with
SELECT * 
FROM players
WHERE name LIKE 'a%';

-- ends with
SELECT * 
FROM players
WHERE name LIKE '%a';

-- second letter
SELECT * 
FROM players
WHERE name LIKE '_a%';

-- anywhere in the result
SELECT * 
FROM players
WHERE name LIKE '%ron%';

-- starts / ends with
SELECT * 
FROM players
WHERE name LIKE 'a%o';

-- contains 2 letters in any position
SELECT * 
FROM players
WHERE name LIKE '%a%b%';

