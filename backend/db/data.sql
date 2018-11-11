USE socialbetdb

# USERS
INSERT INTO users (user_name, first_name, last_name, phone, auth)
VALUES
('cterech', 'Chris','Terech','734-417-6331','HIEOS3753H83FHFKS'), 
('rshelly','Ryan','Shelly','949-290-6670','SDJEI3752E7EFH381J4G9'),
('ncargill','Nick','Cargill','914-479-2054','H3829HVVUELAW8572'),
('isvidler','Ittai','Svilder','912-409-0127', '382HF89EHN29E9321AA'),
('achapp','Alex','Chapp','734-498-0573','3UF920927201F0OSPEU33'),
('jkrieg','John','Krieg','734-201-9423','29720JSWO37GHEBMXNW'),
('taswartz','Trevor','Swartz','914-479-2054','19VUE3HS0HEJ37F35PW0');

# FRIENDS
INSERT INTO friends (user1,user2)
VALUES
('achapp','cterech'),
('achapp','jkrieg'),
('achapp','tschwartz'),
('achapp','ncargill'),
('achapp','isvidler'),
('rshelly','ncargill'),
('cterech','ncargill');

# GAMES
INSERT INTO games(game_id, team1, team2, record1, record2, game_time)
VALUES
(1, 'Detroit Lions', 'Chicago Bears', '1-7', '2-6', '11/18/2018 1:00PM'),
(2, 'New England Patriots', 'Philadelphia Eagles','1-7', '2-6', '11/18/2018 1:00PM'), 
(3, 'Miami Dolphins', 'New Orleans Saints','1-7', '2-6', '11/18/2018 1:00PM'),
(4, 'Pittsburgh Steelers', 'New York Giants','1-7', '2-6', '11/18/2018 3:00PM'),
(5, 'Atlanta Falcons', 'Houston Texans', '1-7', '2-6', '11/18/2018 3:00PM'),
(6, 'Detroit Lions', 'Chicago Bears', '1-7', '2-6','11/22/2018 12:30PM'),
(7, 'New York Giants', 'Philadelphia Eagles', '1-7', '2-6', '11/25/2018 1:00PM'),
(8, 'Seattle Seahawks', 'Carolina Panthers', '1-7', '2-6', '11/25/2018 1:00PM'),
(9, 'Oakland Raiders', 'Baltimore Ravens', '1-7', '2-6', '11/25/2018 1:00PM'),
(10, 'Green Bay Packers', 'Minnesota Vikings', '1-7', '2-6', '11/25/2018 8:20PM'),
(11, 'Cincinnati Bengals', 'Baltimore Ravens', '1-7', '2-6', '11/18/2018 1:00PM'),
(12, 'Denver Broncos', 'Los Angeles Chargers', '1-7', '2-6', '11/18/2018 4:05PM'); 

# BETS
INSERT INTO bets (bet_id, game_id, time_placed, game_time, num_comments, message, ammount, user1, user2, team1, team2, direct, accepted)
VALUES
(1,1,'11/16/2018 3:52PM', '11/18/2018 1:00PM', 0, 'Nick is going down!', 50.0, 'achapp', 'cterech', 'Detroit Lions', 'Chicago Bears', 1, 1), 
(2,3,'11/16/2018 4:19PM', '11/18/2018 1:00PM', 0, 'Ittai is going down!', 100.0, 'achapp', 'jkrieg','Miami Dolphins', 'New Orleans Saints', 1, 1);
