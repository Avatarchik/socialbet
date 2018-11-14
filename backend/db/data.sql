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
(1, 'Tennessee Titans', 'Indianapolis Colts', '/root/socialbet/backend/team_logos/titans.png', '/root/socialbet/backend/team_logos/colts.png', '5-4', '4-5', '11/18/2018 1:00PM'),
(2, 'Tampa Bay Buccaneers', 'New York Giants', '/root/socialbet/backend/team_logos/buccaneers.png', '/root/socialbet/backend/team_logos/giants.png', '3-6', '2-7', '11/18/2018 1:00PM'), 
(3, 'Pittsburgh Steelers', 'Jacksonville Jaguars', '/root/socialbet/backend/team_logos/steelers.png', '/root/socialbet/backend/team_logos/jaguars.png', '6-2-1', '3-6', '11/18/2018 1:00PM'),
(4, 'Carolina Panthers', 'Detroit Lions', '/root/socialbet/backend/team_logos/panthers.png', '/root/socialbet/backend/team_logos/lions.png', '6-3', '3-6', '11/18/2018 1:00PM'),
(5, 'Dallas Cowboys', 'Atlanta Falcons', '/root/socialbet/backend/team_logos/cowboys.png', '/root/socialbet/backend/team_logos/falcons.png', '4-5', '4-5', '11/18/2018 1:00PM'),
(6, 'Cincinnati Bengals', 'Baltimore Ravens', '/root/socialbet/backend/team_logos/bengals.png', '/root/socialbet/backend/team_logos/ravens.png','5-4', '4-5', '11/18/2018 1:00PM'),
(7, 'Houston Texans', 'Washington Redskins', '/root/socialbet/backend/team_logos/texans.png', '/root/socialbet/backend/team_logos/redskins.png', '6-3', '6-3', '11/18/2018 1:00PM'),
(8, 'Oakland Raiders', 'Arizona Cardinals', '/root/socialbet/backend/team_logos/raiders.png', '/root/socialbet/backend/team_logos/cardinals.png', '1-8', '2-7', '11/18/2018 4:05PM'),
(9, 'Denver Broncos', 'Los Angeles Chargers', '/root/socialbet/backend/team_logos/broncos.png', '/root/socialbet/backend/team_logos/dolphins.png', '3-6', '5-5', '11/18/2018 4:05PM'),
(10, 'Philadelphia Eagles', 'New Oreleans Saints', '/root/socialbet/backend/team_logos/eagles.png', '/root/socialbet/backend/team_logos/saints.png', '4-5', '8-1', '11/18/2018 4:25PM'), 
(11, 'Minnesota Vikings', 'Chicago Bears', '/root/socialbet/backend/team_logos/vikings.png', '/root/socialbet/backend/team_logos/bears.png', '5-3', '6-3', '11/18/2018 8:20PM'), 
(12, 'Kansas City Chiefs', 'Los Angeles Rams', '/root/socialbet/backend/team_logos/chiefs.png', '/root/socialbet/backend/team_logos/rams.png', '9-1', '9-1', '11/19/2018 8:15PM'); 

# BETS
INSERT INTO bets (bet_id, game_id, time_placed, game_time, num_comments, message, ammount, user1, user2, team1, team2, direct, accepted)
VALUES
(1,1,'11/16/2018 3:52PM', '11/18/2018 1:00PM', 0, 'Nick is going down!', 50.0, 'achapp', 'cterech', 'Detroit Lions', 'Chicago Bears', 1, 1, 'cterech'), 
(2,3,'11/16/2018 4:19PM', '11/18/2018 1:00PM', 0, 'Ittai is going down!', 100.0, 'achapp', 'jkrieg','Miami Dolphins', 'New Orleans Saints', 1, 1, 'achapp')
