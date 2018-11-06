
from .db_config import get_db_config
import pymysql


def get_users(data):

	# Open database connection
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])

	# prepare a cursor object using cursor() method
	cursor = db.cursor()

	# execute SQL query using execute() method.
	cursor.execute("SELECT * FROM users")

	# Fetch a single row using fetchone() method.
	data = cursor.fetchone()

	# disconnect from server
	db.close()

	return data

def get_user(data):

	user_id = data['user_id']

	# Open database connection
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])

	# prepare a cursor object using cursor() method
	cursor = db.cursor()

	# execute SQL query using execute() method.
	cursor.execute("SELECT * FROM users WHERE uid=\"" + user_id + "\"")

	# Fetch a single row using fetchone() method.
	data = cursor.fetchone()

	# disconnect from server
	db.close()

	return data

def get_bets(direct, live):


	# Open database connection
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])

	# prepare a cursor object using cursor() method
	cursor = db.cursor()

	# execute SQL query using execute() method.
	cursor.execute('SELECT * FROM bets WHERE direct="' + direct + '" and live="' + live+ '"')

	# Fetch a single row using fetchone() method.
	data = cursor.fetchone()

	# disconnect from server
	db.close()

	return data

# functions for user information
def create_user(data):
	#TODO

	# Open database connection
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])

	# prepare a cursor object using cursor() method
	cursor = db.cursor()

	

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




