CREATE TABLE users (
	user_name VARCHAR(100) NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	phone VARCHAR(100),
  	auth VARCHAR(1000) NOT NULL,
 	profile_pic_url VARCHAR(1000),
	PRIMARY KEY(user_name)
);

CREATE TABLE friends ( 
	user1 VARCHAR(20) NOT NULL,
	user2 VARCHAR(20) NOT NULL,
	PRIMARY KEY(user1,user2)
);

CREATE TABLE games (
	game_id INTEGER NOT NULL,
	team1 VARCHAR(50) NOT NULL,
	team2 VARCHAR(50) NOT NULL,
	team1_url VARCHAR(128),
	team2_url VARCHAR(128),
	record1 VARCHAR(50) NOT NULL,
	record2 VARCHAR(50) NOT NULL,
	game_time VARCHAR(50) NOT NULL,
	PRIMARY KEY(game_id)
);

CREATE TABLE bets (
	bet_id INTEGER NOT NULL AUTO_INCREMENT,
	game_id INTEGER NOT NULL,
	time_placed VARCHAR(50) NOT NULL,
	game_time VARCHAR(50) NOT NULL,
	num_comments INT NOT NULL,
	message VARCHAR(50) NOT NULL,
	ammount FLOAT NOT NULL, 
	user1 VARCHAR(50) NOT NULL,
	user2 VARCHAR(50),
	team1 VARCHAR(50) NOT NULL,
	team2 VARCHAR(50) NOT NULL,
    direct INTEGER NOT NULL,
    accepted INTEGER NOT NULL,
    winner VARCHAR(50),
	PRIMARY KEY(bet_id)
);

CREATE TABLE teams (
	team_full_name VARCHAR(100) NOT NULL,
	logo_url VARCHAR(1000) NOT NULL,
	PRIMARY KEY(team_full_name)

);
