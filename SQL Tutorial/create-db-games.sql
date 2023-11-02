

CREATE DATABASE IF NOT EXISTS football_2;

USE football_2;

CREATE TABLE IF NOT EXISTS teams (
  team_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  played int,
  won int,
  draw int,
  lost int,
  points int 
);

CREATE TABLE IF NOT EXISTS players (
  player_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  team_id INT,
  appearances INT NOT NULL,
  goals INT NOT NULL,
  FOREIGN KEY (team_id) REFERENCES teams(team_id) ON DELETE CASCADE
);

ALTER TABLE teams ADD COLUMN position INT;

SET @row_number = 0;
UPDATE teams
SET position = (@row_number:=@row_number+1)
ORDER BY points DESC;

INSERT INTO teams (name, played, won, draw, lost, points) VALUES
('Aberdeen', 0, 0, 0 ,0, 0),
('Celtic', 0, 0, 0 ,0, 0),
('Dundee Utd', 0, 0, 0 ,0, 0),
('Hearts', 0, 0, 0 ,0, 0),
('Hibs', 0, 0, 0 ,0, 0),
('Kilmarnock', 0, 0, 0 ,0, 0),
('Livingston', 0, 0, 0 ,0, 0),
('Motherwell', 0, 0, 0 ,0, 0),
('Rangers', 0, 0, 0 ,0, 0),
('Ross County', 0, 0, 0 ,0, 0),
('St. Johnstone', 0, 0, 0 ,0, 0),
('St. Mirren', 0, 0, 0 ,0, 0);


INSERT INTO players (name, team_id, appearances, goals)
VALUES 
('Alex Johnson', 1, 32, 7),
('Charlie Brown', 1, 25, 5),
('Dave Miller', 1, 40, 12),
('Evan Lee', 1, 28, 8),
('Frank Brown', 2, 22, 3),
('Grace Davis', 2, 41, 9),
('Henry Kim', 2, 35, 11),
('Isabel Lee', 2, 29, 6),
('Jake Anderson', 3, 30, 4),
('Katie Chen', 3, 27, 3),
('Larry Davis', 3, 23, 1),
('Maggie Brown', 3, 33, 7),
('Noah Jones', 4, 36, 14),
('Olivia Wang', 4, 29, 6),
('Paul Smith', 4, 28, 8),
('Quincy Kim', 4, 22, 4),
('Rachel Lee', 5, 20, 2),
('Steve Kim', 5, 25, 5),
('Tina Brown', 5, 32, 9),
('Victor Davis', 5, 31, 7),
('Wendy Chen', 6, 28, 6),
('Xander Kim', 6, 35, 10),
('Yolanda Lee', 6, 31, 8),
('Zack Smith', 6, 24, 3),
('Andrew Davis', 7, 26, 4),
('Betty Brown', 7, 31, 7),
('Charlie Kim', 7, 27, 5),
('Debbie Lee', 7, 32, 8),
('Evan Smith', 8, 22, 3),
('Frances Kim', 8, 29, 5),
('George Davis', 8, 25, 4),
('Hannah Brown', 8, 33, 9),
('Ivy Lee', 9, 31, 7),
('James Kim', 9, 24, 4),
('Kathy Chen', 9, 30, 6),
('Lucas Davis', 9, 29, 5),
('Mia Brown', 10, 32, 8),
('Nick Smith', 10, 27, 5),
('Olivia Lee', 10, 22, 3),
('Ian Livermore', 10, 35, 2),
('Eddie Duncan', 11, 35, 1),
('Phil Kim', 11, 35, 12),
('Jane Ashton', 11, 24, 6),
('Ian Melrose', 11, 38, 0),
('Anna Baird', 12, 38, 0),
('Martin Art', 12, 38, 0),
('Steven Ferguson', 12, 38, 0),
('Melanie Anderson', 12, 38, 0);



ALTER TABLE teams ADD COLUMN position INT;

INSERT INTO teams(name, played, won, draw, lost, points)
VALUES 
('Partick Thistle', 0, 0, 0, 0, 0),
('Dundee', 0, 0, 0, 0, 0);

INSERT INTO players (name, team_id, appearances, goals)
VALUES 
('Ian Grado', 13, 33, 11),
('Arthur Lane', 13, 31, 8),
('Howard King', 13, 38, 2),
('Simon Gold', 13, 23, 17),
('Anna Danson', 14, 23, 4),
('Homer Art', 14, 36, 12),
('Steven Graham', 14, 38, 0),
('Billy Anderson', 14, 34, 8);

-- SET @row_number = 0;
-- UPDATE teams
-- SET position = (@row_number:=@row_number+1)
-- ORDER BY points DESC;





















