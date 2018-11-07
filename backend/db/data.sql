# USERS
INSERT INTO users (user_id, firstname, lastname, birthdate, phone)
VALUES 
(1,'Chris','Terech','05/25/1997','734-417-6331'), 
(2,'Ryan','Shelly','09/22/1996','949-290-6670'),
(3,'Nick','Cargill','01/20/1996','914-479-2054'),
(4,'Ittai','Svilder','02/20/1995','912-409-0127'),
(5,'Alex','Chapp','12/12/1996','734-498-0573'),
(6,'John','Krieg','09/22/1997','734-201-9423'),
(7,'Trevor','Schwartz','10/21/1995','914-479-2054');

# FRIENDS
INSERT INTO friends (user1,user2)
VALUES
(1,3),
(1,2),
(2,3),
(5,6),
(4,6),
(5,1),
(5,2);

# GAMES
INSERT INTO games(cid, team1, team2, gametime)
VALUES 
(1, 'Detroit Lions', 'Chicago Bears', '11/18/2018 1:00PM'),
(2, 'New England Patriots', 'Philadelphia Eagles', '11/18/2018 1:00PM'), 
(3, 'Miami Dolphins', 'New Orleans Saints', '11/18/2018 1:00PM'),
(4, 'Pittsburgh Steelers', 'New York Giants', '11/18/2018 3:00PM'),
(5, 'Atlanta Falcons', 'Houston Texans', '11/18/2018 3:00PM'),
(6, 'Detroit Lions', 'Chicago Bears', '11/22/2018 12:30PM'),
(7, 'New York Giants', 'Philadelphia Eagles', '11/25/2018 1:00PM'),
(8, 'Seattle Seahawks', 'Carolina Panthers', '11/25/2018 1:00PM'),
(9, 'Oakland Raiders', 'Baltimore Ravens', '11/25/2018 1:00PM'),
(10, 'Green Bay Packers', 'Minnesota Vikings', '11/25/2018 8:20PM'),
(11, 'Cincinnati Bengals', 'Baltimore Ravens', '11/18/2018 1:00PM'),
(12, 'Denver Broncos', 'Los Angeles Chargers', '11/18/2018 4:05PM'); 

# BETS
INSERT INTO bets (bet_id, contest_id, time_placed, game_time, num_comments, message, ammount, user1, user2, direct, accepted)
VALUES (1,1,'11/16/2018 3:52PM', '11/18/2018 1:00PM', 0, 'Nick is going down!', 50.0, 1, 3, 1, 1), 
(2,3,'11/16/2018 4:19PM', '11/18/2018 1:00PM', 0, 'Ittai is going down!', 100.0, 6, 4, 0, 1);
