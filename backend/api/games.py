from flask import Flask
from .api_utils import create_http_response

app = Flask(__name__)

@app.route('/api/games/get_games/')
def get_games():
	# TODO

	return create_http_response()
