# Social Bet Database
USE socialbetdb;

CREATE TABLE users (
	uid INTEGER NOT NULL,
	firstname VARCHAR(20) NOT NULL,
	lastname VARCHAR(20) NOT NULL,
	birthdate VARCHAR(20) NOT NULL,
	phone VARCHAR(12),
	PRIMARY KEY(uid)
);

CREATE TABLE friends ( 
<<<<<<< HEAD:db/schema.sql
	user1id INT NOT NULL,
	user2id INT,
	PRIMARY KEY(user1id,user2id),
	FOREIGN KEY(user1id) REFERENCES users(uid)
);

CREATE TABLE bets (
	bid INT NOT NULL,
	cid INT NOT NULL,
	value DOUBLE(10,2) NOT NULL, 
	user1id INT NOT NULL,
	user2id INT,
=======
	user1id INTEGER NOT NULL,
	user2id INTEGER,
	PRIMARY KEY(user1id,user2id),
	FOREIGN KEY(user1id) REFERENCES users(uid),
	FOREIGN KEY(user2id) REFERENCES users(uid)
);

CREATE TABLE bets (
	bid INTEGER NOT NULL,
	cid INTEGER NOT NULL,
	value FLOAT NOT NULL, 
	user1id INTEGER NOT NULL,
	user2id INTEGER,
>>>>>>> 4ee0ae85fae0137f1b6b78fca4a88b84edcfb65e:backend/db/schema.sql
	sport VARCHAR(50) NOT NULL,
	timeplaced DATE NOT NULL,
	timeaccepted DATE,
	PRIMARY KEY(bid),
	FOREIGN KEY(user1id) REFERENCES users(uid),
	FOREIGN KEY(user2id) REFERENCES users(uid)
);
