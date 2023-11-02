CREATE DATABASE IF NOT EXISTS stats;

USE stats;

CREATE TABLE IF NOT EXISTS teams (
  team_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  league VARCHAR(255) NOT NULL,
  games_total int NOT NULL,
  btts_total int NOT NULL,
  over_0_5_total int NOT NULL,
  over_1_5_total int NOT NULL,
  over_2_5_total int NOT NULL,
  over_3_5_total int NOT NULL,
  over_4_5_total int NOT NULL,
  corners_total int NOT NULL,
  cards_total int NOT NULL
);

CREATE TABLE IF NOT EXISTS matches (
  match_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  home_team_id INT NOT NULL,
  away_team_id INT NOT NULL,
  FOREIGN KEY (home_team_id) REFERENCES teams(team_id) ON DELETE CASCADE,
  FOREIGN KEY (away_team_id) REFERENCES teams(team_id) ON DELETE CASCADE,
  league VARCHAR(255) NOT NULL
);


