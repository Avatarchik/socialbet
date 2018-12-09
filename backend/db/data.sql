# USERS
INSERT INTO users (user_name, first_name, last_name, phone, profile_pic_url, auth, private_key, public_key)
VALUES
('cterech', 'Chris','Terech','7344176331', '/user_profile_pics/terech.jpg', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8', '0x9c37ad7e464631531442839a846c7d718a63a2553daf58fe0d0e957292170ec0', '0xfb41eda87755502eff5c37e52cc9030d84461af2'),
('rshelly','Ryan','Shelly','9492906670', '/user_profile_pics/shelly.jpg', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8', '0x83bf27fdcf81ad304d2e6daa5c4f5959c60ba282e2a4b532ce3dfd3b1c5b1f6d', '0xad4c010a76206bf772239b831baa0d7b25694b27'),
('ncargill','Nick','Cargill','9144792054', '/user_profile_pics/cargill.jpg', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8', '0xf9b093ab0660924e316720e6ec7eb7789c938434fa03a3cad1b5270e104adf8a', '0x141172ff6c189cb05507744d7bdb12792bf29771'),
('isvidler','Ittai','Svilder','9124090127', '/user_profile_pics/svidler.jpg', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8', '0xebf754d76b011c0e3932a8764f2e9395c19398a9530251aa8f134e00dc44e532', '0xfa76372e172db987e7105df1439d6aac0219db44'),
('achapp','Alex','Chapp','7344980573', '/user_profile_pics/chapp.jpg', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8', '0x5b9ed1b9896955b537eb9668ff61f0fdc9b885daf74672acd7e7b947b6b9fb61', '0xcd6d30bbfbc2d702cf3a330707c01136914b798a'),
('jkrieg','John','Krieg','7342019423', '/user_profile_pics/krieg.jpg', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8', '0x59b72e3bf37261065d7eac20d283eebfbb0756848b46d501c11da2030c0b4232', '0x212e9b2d93e30f6a5f46f42c5a89f57a07a58c35'),
('tswartz','Trevor','Swartz','9144792054', '/user_profile_pics/swartz.jpg', '5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8', '0xc39eea288bd255342409575acf9e22b66e7a2efa991cf45bea8badf2e243946f', '0x0c876dda3c8672a0490d9272313666e4dbf39cc9');

# FRIENDS
INSERT INTO friends (user1,user2)
VALUES
('achapp','cterech'),
('achapp','jkrieg'),
('achapp','tswartz'),
('achapp','ncargill'),
('achapp','isvidler'),
('rshelly','ncargill'),
('cterech','ncargill');

# GAMES
INSERT INTO games(game_id, team1, team2, team1_url, team2_url, record1, record2, game_time)
VALUES
(12, 'Seattle Seahawks', 'Minnesota Vikings', '/team_logos/seahawks.png', '/team_logos/vikings.png', '7-5','6-5','12/10/2018 7:15PM'),
(13, 'Atlanta Falcons', 'Arizona Cardinals', '/team_logos/falcons.png', '/team_logos.png', '4-8', '3-9', '12/16/2018 1:00PM'),
(14, 'Cincinnati Bengals', 'Oakland Raiders', '/team_logos/bengals.png', '/team_logos/raiders.png', '5-7', '2-10', '12/16/2018 1:00PM'),
(15, 'Minnesota Vikings', 'Miami Dolphins', '/team_logos/vikings.png', '/team_logos/dolphins.png', '6-5', '6-6', '12/16/2018 1:00PM'),
(16, 'Indianapolis Colts', 'Dallas Cowboys', '/team_logos/colts.png', '/team_logos/cowboys.png', '6-6','7-5', '12/16/2018 1:00PM'),
(17, 'Baltimore Ravens', 'Tampa Bay Buccaneers', '/team_logos/ravens.png', '/team_logos/buccaneers.png', '7-5', '5-7', '12/16/2018 1:00PM'),
(18, 'Buffalo Bills', 'Detroit Lions', '/team_logos/bills.png', '/team_logos/lions.png', '4-8', '4-8', '12/16/2018 1:00PM'),
(19, 'Chicago Bears', 'Green Bay Packers', '/team_logos/bears.png', '/team_logos/packers.png', '8-4', '4-7', '12/16/2018 1:00PM'),
(20, 'Jacksonville Jaguars', 'Washington Redskins', '/team_logos/jaguars.png', '/team_logos/redskins.png', '4-8', '6-6', '12/16/2018 12:00PM'),
(21, 'New York Giants', 'Tennessee Titans', '/team_logos/giants.png', '/team_logos/titans.png', '4-8','6-6','12/16/2018 12:00PM'),
(22, 'San Francisco 49ers', 'Seattle Seahawks', '/team_logos/49ers.png', '/team_logos/seahawks.png', '2-9', '7-5', '12/16/2018 3:05PM'),
(23, 'Pittsburgh Steelers', 'New England Patriots', '/team_logos/steelers.png', '/team_logos/patriots.png', '7-4', '9-3', '12/16/2018 3:25PM'),
(24, 'Los Angeles Rams', 'Philadelphia Eagles', '/team_logos/rams.png', '/team_logos/eagles.png', '11-1', '6-6', '12/16/2018 7:20PM'),
(25, 'Carolina Panthers', 'New Orleans Saints', '/team_logos/panthers.png', '/team_logos/saints.png','6-6', '10-2', '12/17/2018 7:15PM');

# BETS
# cterech = 1
# rshelly = 2
# ncargill = 3
# isvidler = 4
# achapp = 5
# jkrieg = 6
# twartz = 7
INSERT INTO bets (bet_id, game_id, time_placed, game_time, num_comments, message, ammount, user1, user2, user1_id, user2_id, team1, team2, direct, accepted, winner, notified, team1_score, team2_score)
VALUES
(1,1,'11/13/2018 3:52PM', '11/18/2018 1:00PM', 0, 'Chapp is going down!', 20.0, 'achapp', 'cterech', 5, 1, 'Tennessee Titans', 'Indianapolis Colts', 1, 1,NULL, 0, '30', '70'), 
(2,4,'11/13/2018 4:19PM', '11/18/2018 1:00PM', 1, 'Ittai is going down!', 100.0, 'achapp', 'jkrieg', 5, 6, 'Carolina Panthers', 'Detroit Lions', 1, 0,NULL, 0, NULL, NULL),
(3,7,'11/13/2018 3:52PM', '11/18/2018 1:00PM', 0, 'This will be easy!', 5.0, 'achapp', 'cterech', 5,1, 'Houston Texans', 'Washington Redskins', 0, 1, 'cterech', 0, '21', '71'), 
(4,2,'11/13/2018 4:19PM', '11/18/2018 1:00PM', 2, 'Lets go!!!!!', 10.0, 'ncargill', 'rshelly', 3,2,'Tampa Bay Buccaneers', 'New York Giants', 1, 1, 'rshelly', 0, '7', '32'),
(5,3,'11/13/2018 3:52PM', '11/18/2018 1:00PM', 0, 'This is just easy money', 50.0, 'cterech', 'isvidler',1,4, 'Pittsburgh Steelers', 'Jacksonville Jaguars', 1, 0, NULL, 0, NULL, NULL), 
(6,3,'11/13/2018 4:19PM', '11/18/2018 1:00PM', 0, 'We love sports', 100.0, 'achapp', 'jkrieg', 5,6, 'Pittsburgh Steelers', 'Jacksonville Jaguars', 0, 1,NULL, 0, NULL, NULL),
(7,4,'11/13/2018 3:52PM', '11/18/2018 1:00PM', 1, 'Lets ride', 20.0, 'ncargill', 'tswartz', 3,7, 'Carolina Panthers', 'Detroit Lions', 0, 0, NULL, 0, NULL, NULL), 
(8,4,'11/13/2018 4:19PM', '11/18/2018 1:00PM', 0, 'Matchup of the century', 10.0, 'tswartz', 'jkrieg', 7,6, 'Carolina Panthers', 'Detroit Lions', 1, 0,NULL, 0, NULL, NULL),
(9,10,'11/14/2018 3:52PM', '11/18/2018 4:25PM', 7, 'Just two sports enthusiasts going after it', 50.0, 'jkrieg', 'rshelly',6,2, 'Philadelphia Eagles', 'New Oreleans Saints', 0, 1, 'jkrieg', 1, '7', '0'), 
(10,12,'11/14/2018 4:19PM', '11/19/2018 8:15PM', 0, 'The Michigan boys', 10.0, 'achapp', 'jkrieg', 5,6,'Kansas City Chiefs', 'Los Angeles Rams', 0, 0, NULL, 0, NULL, NULL),
(11,2,'11/14/2018 3:52PM', '11/18/2018 1:00PM', 0, 'Detroit and Michigan football forever', 5.0, 'achapp', 'cterech',5,1, 'Tampa Bay Buccaneers', 'New York Giants', 1, 1, 'cterech', 1, '7', '42'), 
(12,11,'11/14/2018 4:19PM', '11/18/2018 8:20PM', 0, 'Need to win my rent money back!', 15.0, 'achapp', 'jkrieg', 5,6,'Minnesota Vikings', 'Chicago Bears', 1, 0, NULL, 0, NULL, NULL),
(13,8,'11/14/2018 3:52PM', '11/18/2018 4:05PM', 1, 'This should be interesting', 25.0, 'achapp', 'cterech',5,1, 'Oakland Raiders', 'Arizona Cardinals', 0, 1, 'cterech', 1, '21', '23'), 
(14,6,'11/15/2018 4:19PM', '11/18/2018 1:00PM', 0, 'I need money', 150.0, 'achapp', 'jkrieg', 5,6,'Cincinnati Bengals', 'Baltimore Ravens', 1, 1, 'achapp', 1, '10', '0'),
(15,5,'11/15/2018 3:52PM', '11/18/2018 1:00PM', 2, 'Giants = super bowl champions', 20.0, 'achapp', 'cterech', 5,1, 'Dallas Cowboys', 'Atlanta Falcons', 0, 1, 'cterech', 1, '0', '70'), 
(16,4,'11/15/2018 4:19PM', '11/18/2018 1:00PM', 0, 'Eassssyyyyy money', 25.0, 'achapp', 'jkrieg', 5,6,'Carolina Panthers', 'Detroit Lions', 1, 0, NULL, 0, NULL, NULL),
(17,3,'11/15/2018 3:52PM', '11/18/2018 1:00PM', 3, 'Loser is paying for pizza too!', 5.0, 'achapp', 'cterech', 5,1, 'Pittsburgh Steelers', 'Jacksonville Jaguars', 1, 1, 'cterech', 1, '12', '13'), 
(18,1,'11/16/2018 4:19PM', '11/18/2018 1:00PM', 0, 'Settling this once and for all', 10.0, 'achapp', 'jkrieg', 5,6,'Tennessee Titans', 'Indianapolis Colts', 1, 1, 'achapp', 1, '21', '7'),
(19,6,'11/16/2018 3:52PM', '11/18/2018 1:00PM', 4, 'This will be easy', 50.0, 'achapp', 'cterech',5,1, 'Cincinnati Bengals', 'Baltimore Ravens', 0, 1, 'cterech', 1, '7', '21'), 
(20,6,'11/16/2018 4:19PM', '11/18/2018 1:00PM', 0, 'We love sports betting', 100.0, 'achapp', 'jkrieg',5,6,'Cincinnati Bengals', 'Baltimore Ravens', 1, 0, NULL, 0, NULL, NULL),
(21,12,'11/16/2018 4:19PM', '11/19/2018 8:15PM', 1, 'Lets settle this', 10.0, 'achapp', 'jkrieg',5,6,'Kansas City Chiefs', 'Los Angeles Rams', 0, 0, NULL, 0, NULL, NULL),
(22,12,'11/16/2018 3:52PM', '11/19/2018 8:15PM', 1, 'Youre on, pal!', 5.0, 'achapp', 'cterech',5,1,'Kansas City Chiefs', 'Los Angeles Rams', 0, 0, NULL, 0, NULL, NULL),
(23,12,'11/16/2018 4:19PM', '11/19/2018 8:15PM', 0, 'Ittai is going to lose!', 5.0, 'achapp', 'jkrieg',5,6,'Kansas City Chiefs', 'Los Angeles Rams', 0, 0, NULL, 0, NULL, NULL);

# ADDING TEAM INFO INTO DATABASE
INSERT INTO teams (team_full_name, logo_url) VALUES
('Arizona Cardinals', '/team_logos/cardinals.png'),
('Atlanta Falcons', '/team_logos/falcons.png'),
('Baltimore Ravens', '/team_logos/ravens.png'),
('Buffalo Bills', '/team_logos/bills.png'),
('Carolina Panthers', '/team_logos/panthers.png'),
('Chicago Bears', '/team_logos/bears.png'),
('Cincinnati Bengals', '/team_logos/bengals.png'),
('Cleveland Browns', '/team_logos/browns.png'),
('Dallas Cowboys', '/team_logos/cowboys.png'),
('Denver Broncos', '/team_logos/broncos.png'),
('Detroit Lions', '/team_logos/lions.png'),
('Green Bay Packers', '/team_logos/packers.png'),
('Houston Texans', '/team_logos/texans.png'),
('Indianapolis Colts', '/team_logos/colts.png'),
('Jacksonville Jaguars', '/team_logos/jaguars.png'),
('Kansas City Chiefs', '/team_logos/chiefs.png'),
('Miami Dolphins', '/team_logos/dolphins.png'),
('Minnesota Vikings', '/team_logos/vikings.png'),
('New England Patriots', '/team_logos/patriots.png'),
('New Orleans Saints', '/team_logos/saints.png'),
('New York Giants', '/team_logos/giants.png'),
('New York Jets', '/team_logos/jets.png'),
('Oakland Raiders', '/team_logos/raiders.png'),
('Philadelphia Eagles', '/team_logos/eagles.png'),
('Pittsburgh Steelers', '/team_logos/steelers.png'),
('Los Angeles Chargers', '/team_logos/chargers.png'),
('San Francisco 49ers', '/team_logos/49ers.png'),
('Seattle Seahawks', '/team_logos/seahawks.png'),
('Los Angeles Rams', '/team_logos/rams.png'),
('Tampa Bay Buccaneers', '/team_logos/buccaneers.png'),
('Tennessee Titans', '/team_logos/titans.png'),
('Washington Redskins', '/team_logos/redskins.png');









