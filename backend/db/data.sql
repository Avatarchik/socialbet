# USERS
INSERT INTO users (user_name, first_name, last_name, phone, profile_pic_url, auth)
VALUES
('cterech', 'Chris','Terech','734-417-6331', '/root/socialbet/backend/user_profile_pics/terech.png', 'HIEOS3753H83FHFKS'), 
('rshelly','Ryan','Shelly','949-290-6670', '/root/socialbet/backend/user_profile_pics/shelly.png', 'SDJEI3752E7EFH381J4G9'),
('ncargill','Nick','Cargill','914-479-2054', '/root/socialbet/backend/user_profile_pics/cargill.png', 'H3829HVVUELAW8572'),
('isvidler','Ittai','Svilder','912-409-0127', '/root/socialbet/backend/user_profile_pics/svidler.png', '382HF89EHN29E9321AA'),
('achapp','Alex','Chapp','734-498-0573', '/root/socialbet/backend/user_profile_pics/chapp.png', '3UF920927201F0OSPEU33'),
('jkrieg','John','Krieg','734-201-9423', '/root/socialbet/backend/user_profile_pics/krieg.png', '29720JSWO37GHEBMXNW'),
('taswartz','Trevor','Swartz','914-479-2054', '/root/socialbet/backend/user_profile_pics/swartz.png', '19VUE3HS0HEJ37F35PW0');

# FRIENDS
INSERT INTO friends (user1,user2)
VALUES
('achapp','cterech'),
('achapp','jkrieg'),
('achapp','taswartz'),
('achapp','ncargill'),
('achapp','isvidler'),
('rshelly','ncargill'),
('cterech','ncargill');

# GAMES
INSERT INTO games(game_id, team1, team2, team1_url, team2_url, record1, record2, game_time)
VALUES
(1, 'Detroit Lions', 'Chicago Bears', '/root/socialbet/backend/team_logos/lions.png', '/root/socialbet/backend/team_logos/bears.png', '1-7', '2-6', '11/18/2018 1:00PM'),
(2, 'New England Patriots', 'Philadelphia Eagles', '/root/socialbet/backend/team_logos/patriots.png', '/root/socialbet/backend/team_logos/eagles.png', '1-7', '2-6', '11/18/2018 1:00PM'), 
(3, 'Miami Dolphins', 'New Orleans Saints', '/root/socialbet/backend/team_logos/dolphins.png', '/root/socialbet/backend/team_logos/saints.png', '1-7', '2-6', '11/18/2018 1:00PM'),
(4, 'Pittsburgh Steelers', 'New York Giants', '/root/socialbet/backend/team_logos/steelers.png', '/root/socialbet/backend/team_logos/giants.png', '1-7', '2-6', '11/18/2018 3:00PM'),
(5, 'Atlanta Falcons', 'Houston Texans', '/root/socialbet/backend/team_logos/falcons.png', '/root/socialbet/backend/team_logos/texans.png', '1-7', '2-6', '11/18/2018 3:00PM'),
(6, 'Seattle Seahawks', 'Carolina Panthers', '/root/socialbet/backend/team_logos/seahawks.png', '/root/socialbet/backend/team_logos/panthers.png','1-7', '2-6', '11/25/2018 1:00PM'),
(7, 'Oakland Raiders', 'Baltimore Ravens', '/root/socialbet/backend/team_logos/raiders.png', '/root/socialbet/backend/team_logos/ravens.png', '1-7', '2-6', '11/25/2018 1:00PM'),
(8, 'Green Bay Packers', 'Minnesota Vikings', '/root/socialbet/backend/team_logos/packers.png', '/root/socialbet/backend/team_logos/vikings.png', '1-7', '2-6', '11/25/2018 8:20PM'),
(9, 'Cincinnati Bengals', 'Miami Dolphins', '/root/socialbet/backend/team_logos/bengals.png', '/root/socialbet/backend/team_logos/dolphins.png', '1-7', '2-6', '11/18/2018 1:00PM'),
(10, 'Denver Broncos', 'Los Angeles Chargers', '/root/socialbet/backend/team_logos/broncos.png', '/root/socialbet/backend/team_logos/charges.png', '1-7', '2-6', '11/18/2018 4:05PM'); 

# BETS
INSERT INTO bets (bet_id, game_id, time_placed, game_time, num_comments, message, ammount, user1, user2, team1, team2, direct, accepted)
VALUES
(1,1,'11/16/2018 3:52PM', '11/18/2018 1:00PM', 0, 'Nick is going down!', 50.0, 'achapp', 'cterech', 'Detroit Lions', 'Chicago Bears', 1, 1), 
(2,3,'11/16/2018 4:19PM', '11/18/2018 1:00PM', 0, 'Ittai is going down!', 100.0, 'achapp', 'jkrieg','Miami Dolphins', 'New Orleans Saints', 1, 1);
