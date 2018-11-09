from flask import Flask, Blueprint
from .api_utils import create_http_response

app = Flask(__name__)
games = Blueprint('games', __name__)

@games.route('/api/v1/games/')
def get_games():
	# TODO: create games json object and return it


    # check authentication

    # make query    

    # JSONify query

    # return

	return "Hello Games!"
