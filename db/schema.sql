# Social Bet Database
CREATE DATABASE socialbetdb;
USE socialbetdb;

CREATE TABLE users (
	uid INT NOT NULL,
	firstname VARCHAR(20) NOT NULL,
	lastname VARCHAR(20) NOT NULL,
	birthdate VARCHAR(20) NOT NULL,
	phone VARCHAR(12),
	PRIMARY KEY(uid)
);

CREATE TABLE friends ( 
	user1id INT NOT NULL,
	user2id INT,
	PRIMARY KEY(user1,user2),
	FOREIGN KEY(user1id) REFERENCES users(uid)
);

CREATE TABLE bets (
	bid INT NOT NULL,
	cid INT NOT NULL,
	value  NOT NULL, 
	user1id INT NOT NULL,
	user2id INT,
	sport VARCHAR(50) NOT NULL,
	timeplaced DATE NOT NULL,
	timeaccepted DATE,
	PRIMARY KEY(obid),
	FOREIGN KEY(user1id) REFERENCES users(uid),
	FOREIGN KEY(user2id) REFERENCES users(uid)
);