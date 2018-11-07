from flask import Flask, Blueprint
from .api_utils import create_http_response

app = Flask(__name__)
games = Blueprint('games', __name__)

@app.route('/api/games/get_games/')
def get_games():
	# TODO

	return create_http_response()
