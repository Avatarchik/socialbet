INSERT INTO users (uid, firstname, lastname, birthdate, phone)
VALUES (1,'Chris','Terech','05/25/1997','734-417-6331');

INSERT INTO users (uid, firstname, lastname, birthdate, phone)
VALUES (2,'Ryan','Shelly','09/22/1996','949-290-6670');

INSERT INTO users (uid, firstname, lastname, birthdate, phone)
VALUES (3,'Nick','Cargill','5th-year','914-479-2054');

INSERT INTO friends (user1id,user2id)
VALUES (1,3);

INSERT INTO friends (user1id,user2id)
VALUES (1,2);

INSERT INTO friends (user1id,user2id)
VALUES (2,3);

INSERT INTO bets (bid,cid,value,user1id,user2id,sport,timeplaced,timeaccepted)
VALUES (1,1,50.00,1,3,'NFL',CURDATE(),CURDATE());

INSERT INTO bets (bid,cid,value,user1id,user2id,sport,timeplaced,timeaccepted)
VALUES (2,27,2700.00,2,3,'NBA',CURDATE(),CURDATE());