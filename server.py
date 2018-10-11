from flask import Flask
import os

# Create flask app
def create_app(test_config=None):
	app = Flask(__name__)
	# create and configure the app
	app = Flask(__name__, instance_relative_config=True)
	app.config.from_mapping(
		SECRET_KEY='dev',
	)

	# set up configuration
	if test_config is None:
		# load the instance config, if it exists, when not testing
		app.config.from_pyfile('config.py', silent=True)
	else:
		# load the test config if passed in
		app.config.from_mapping(test_config)

	# ensure the instance folder exists
	try:
		os.makedirs(app.instance_path)
	except OSError:
		pass
	app.run()

if __name__ == '__main__':
	test_config = {

	}
	create_app()
