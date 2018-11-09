USE socialbetdb;

CREATE TABLE users (
	user_name VARCCHAR(50) NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	birth_date VARCHAR(20) NOT NULL,
	phone VARCHAR(12),
	PRIMARY KEY(user_name)
);

CREATE TABLE friends ( 
	user1 VARCHAR(20) NOT NULL,
	user2 VARCHAR(20) NOT NULL,
	PRIMARY KEY(user1,user2),
	FOREIGN KEY(user1) REFERENCES users(user_id)
);

CREATE TABLE games (
	game_id INTEGER NOT NULL,
	team1 VARCHAR(50) NOT NULL,
	team2 VARCHAR(50) NOT NULL,
	record1 VARCHAR(50) NOT NULL,
	record2 VARCHAR(50) NOT NULL,
	game_time VARCHAR(50) NOT NULL,
	PRIMARY KEY(game_id)
);

CREATE TABLE bets (
	bet_id INTEGER NOT NULL,
	game_id INTEGER NOT NULL,
	time_placed VARCHAR(50) NOT NULL,
	game_time VARCHAR(50) NOT NULL,
	num_comments INT NOT NULL,
	message VARCHAR(50) NOT NULL,
	ammount FLOAT NOT NULL, 
	user1 VARCHAR(50) NOT NULL,
	team1 VARCHAR(50),
	team2 VARCHAR(50),
	user2 VARCHAR(50),
    direct INTEGER NOT NULL,
    accepted INTEGER NOT NULL,
	PRIMARY KEY(bet_id),
	FOREIGN KEY(user1) REFERENCES users(user_name),
	FOREIGN KEY(user2) REFERENCES users(user_name)
);
