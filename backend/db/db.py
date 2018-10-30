
from .db_config import get_db_config
import pymysql


def get_users(data):
	#TODO

	# Open database connection
	db_config = get_db_config()
	db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])

	# prepare a cursor object using cursor() method
	cursor = db.cursor()

	# execute SQL query using execute() method.
	# TODO:
	cursor.execute("SELECT VERSION()")

	# Fetch a single row using fetchone() method.
	data = cursor.fetchone()
	print ("Database version : %s " % data)

	# disconnect from server
	db.close()
	pass

def create_user(data):
	#TODO
	pass

def place_bet(data):
	#TODO
	pass
