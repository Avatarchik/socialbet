from flask import Flask
import os
from .api import betting, feeds, games, users

app = Flask(__name__, instance_relative_config=True)
app.register_blueprint(betting.betting)
app.register_blueprint(feeds.feeds)
app.register_blueprint(games.games)
app.register_blueprint(users.users)

# Create flask app
def create_app(test_config=None):
	# create and configure the app
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

if __name__ == '__main__':
	test_config = {

	}
	create_app()

	app.run()
