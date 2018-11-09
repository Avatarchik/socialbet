
from .db_config import get_db_config
import pymysql

def authenticate(username, auth):
    # check to see if this {username, auth} tuple is in the db
    # TODO: Chris
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()
   
    sql = "SELECT user_name FROM users WHERE user_name = " + username + "AND auth = " + auth
    cursor.execute(sql)

    for row in cursor:
        if row == username
            return True

    return False

########################## USERS ###########################################################
# I DONT NEED ANYTHING
def get_users():
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()
	
	sql = "SELECT * FROM users;"
	cursor.execute(sql)


	res = []
	for row in cursor:
		res.append(row)

	db.close()
	return res

# I NEED USER_ID
def get_user(data):
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()
	
	user_name = data['user_name']

	sql = "SELECT * FROM users WHERE user_name = " + user_name + ";"
	cursor.execute(sql)

	res = []
	for row in cursor:
		res.append(row)

	db.close()

	return res

# I NEED ALL USER INFO
def create_user(data):
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()


	user_name = data['user_name']
	first_name = data['first_name']
	last_name = data['last_name']
	birthdate = data['birth_date']
	phone = data['phone']
	sql = "INSERT INTO users VALUES ( " + user_name + ", " + first_name + ", " + last_name + ", " + 
	birthdate + ", "  + phone + ");"

	cursor.execute(sql)
	res = []
	for row in cursor:
		res.append(row)


	db.close()

	return res

# I NEED ONLY USER_ID
def drop_user(data):
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()

	user_id = data['user_name']
	sql = "DELETE FROM users WHERE user_name = " + user_name + ";"
	
	cursor.execute(sql)
	res = []
	for row in cursor:
		res.append(row)


	db.close()

	return res

########################## FRIENDS ###########################################################
# I NEED USER_ID ONLY
# WE ARE SHIFTING OVER TO USING USERNAME AS IDENTIFIER
def get_friends(data):
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()
	
	user_name = data['user_name']

	sql = "SELECT user2 FROM friends WHERE user1 = " + user_name + ";"

	cursor.execute(sql)

	res = []
	for row in cursor:
		res.append(row)


	db.close()

	return res

########################## GAMES ###########################################################
def get_games():
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()
	
	sql = "SELECT * FROM games;"

	cursor.execute(sql)

	res = []
	for row in cursor:
		res.append(row)


	db.close()

	return res

########################## BETS ###########################################################
# THEY WILL PASS ME A USERID, I WILL RETURN ALL OF THE USERS BETS AND THE USERS FRIENDS BETS
# GET ONE FOR LIVE BETS AND ONE FOR OPEN BETS
def get_live_bets(data):
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()

	user_name = data['user_name']

	sql = "SELECT * FROM bets WHERE user1 = (SELECT user2 FROM friends WHERE user1 = " + user_name + " " + ") AND accepted=1;"
	cursor.execute(sql)

	res = []
	for row in cursor:
		res.append(row)


	db.close()

	return res

def get_open_bets(data):
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()

	sql = "SELECT * FROM bets WHERE user1 = (SELECT user2 FROM friends WHERE user1 = " + user_name + " " + ") AND accepted=0;"

	cursor.execute(sql)

	res = []
	for row in cursor:
		res.append(row)


	db.close()

	return res

# I NEED ALL BET INFO
# JUST GETTING TWO TEAMS
def place_bet(data):
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()

	time_placed = data['time_placed']
	game_time = data['game_time']
	message = data['message']
	ammount = data['ammount']
	user1 = data['user1']
	user2 = data['user2']
	team1 = data['team1']
	team2 = data['team2']
    direct = data['direct']
    accepted = data['accepted']

    sql = "SELECT game_id FROM games WHERE team1 = " + team1 + " AND team2 = " + team2 ";"
    cursor.execute(sql)
    game_id = cursor.fetchall()

    sql = "INSERT INTO bets VALUES ( NEWID()" + ", " + game_id + ", "
    time_placed + ", " + game_time + ", "
    message + ", " + ammount + ", " + user1 + ", "+ user2 + ", " 
    team1 + ", " + team2 + ", " + direct + ", " + accepted + ");"

	cursor.execute(sql)
	db.close()

	return
