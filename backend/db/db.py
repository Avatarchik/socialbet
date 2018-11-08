
from .db_config import get_db_config
import pymysql


def get_users():

	# Open database connection
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()
	
	sql = "SELECT * FROM users"
	cursor.execute(sql)


	res = []
	for row in cursor:
		res.append(row)

	db.close()
	return res

def get_user(data):

	user_id = data['user_id']
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()
	
	sql = "SELECT * FROM users WHERE uid = " + user_id
	cursor.execute(sql)

	res = []
	for row in cursor:
		res.append(row)

	db.close()

	return res

def get_bets(direct, live):

	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])

	cursor = db.cursor()

	sql = "SELECT * FROM bets WHERE direct= " + direct + " " + "and live = " + live
	cursor.execute(sql)

	res = []
	for row in cursor:
		res.append(row)


	db.close()

	return res

# functions for user information
def create_user(data):
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
	cursor = db.cursor()


	user_id = data['user_id']
	first_name = data['first_name']
	sql = "INSERT INTO users VALUES ( " + user_id + "," + 


	pass

def drop_user(data):
	#TODO
	pass

# functions for bet information
def place_bet(data):
	#TODO
	pass

# functions for friends information
def get_friends(data):
	#TODO
	pass




