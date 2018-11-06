CREATE TABLE users (
	uid INTEGER NOT NULL,
	firstname VARCHAR(20) NOT NULL,
	lastname VARCHAR(20) NOT NULL,
	birthdate VARCHAR(20) NOT NULL,
	phone VARCHAR(12),
	PRIMARY KEY(uid)
);

CREATE TABLE friends ( 
	user1 INT NOT NULL,
	user2 INT,
	PRIMARY KEY(user1id,user2id),
	FOREIGN KEY(user1id) REFERENCES users(uid)
);

CREATE TABLE games (
	cid INTEGER NOT NULL,
	team1 VARCHAR(50) NOT NULL,
	team2 VARCHAR(50) NOT NULL,
	gametime VARCHAR(50) NOT NULL
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
	PRIMARY KEY(bid),
	FOREIGN KEY(user1id) REFERENCES users(uid),
	FOREIGN KEY(user2id) REFERENCES users(uid)
);
