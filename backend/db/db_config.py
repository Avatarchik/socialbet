from .. import config

# TODO: Update parameters
production_db = {
	'host': 'localhost',
	'username': '<username>',
	'password': '<password>',
	'database_name': '<database name>'
}

# TODO: Update parameters
test_db = {
	'host': 'localhost',
	'username': '<username>',
	'password': '<password>',
	'database_name': '<database name>'
}

def get_db_config():

	return production_db if config.environment == 'production' else test_db

