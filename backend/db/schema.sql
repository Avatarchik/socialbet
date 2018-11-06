CREATE TABLE users (
	uid INTEGER NOT NULL,
	firstname VARCHAR(20) NOT NULL,
	lastname VARCHAR(20) NOT NULL,
	birthdate VARCHAR(20) NOT NULL,
	phone VARCHAR(12),
	PRIMARY KEY(user_id)
);

CREATE TABLE friends ( 
	user1 INT NOT NULL,
	user2 INT,
	PRIMARY KEY(user1,user2),
	FOREIGN KEY(user1) REFERENCES users(user_id)
);

CREATE TABLE games (
	cid INTEGER NOT NULL,
	team1 VARCHAR(50) NOT NULL,
	team2 VARCHAR(50) NOT NULL,
	gametime VARCHAR(50) NOT NULL,
	PRIMARY KEY(cid)
);

CREATE TABLE bets (
	bet_id INTEGER NOT NULL,
	contest_id INTEGER NOT NULL,
	time_placed VARCHAR(50) NOT NULL,
	game_time VARCHAR(50) NOT NULL,
	num_comments INT NOT NULL,
	message VARCHAR(50) NOT NULL,
	ammount FLOAT NOT NULL, 
	user1 INTEGER NOT NULL,
	user2 INTEGER,
    direct INTEGER NOT NULL,
    accepted INTEGER NOT NULL,
	PRIMARY KEY(bet_id),
	FOREIGN KEY(user1) REFERENCES users(user_id),
	FOREIGN KEY(user2) REFERENCES users(user_id)
);
