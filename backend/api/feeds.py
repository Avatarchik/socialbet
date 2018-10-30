from flask import Flask
import db
from .api_utils import create_http_response

app = Flask(__name__)

@app.route('/api/feeds/open_bets/')
def list_open_bets():
	# TODO
	open_bets = db.get_open_bets()

	return create_http_response()

@app.route('/api/feeds/closed_bets')
def list_closed_bets():
	# TODO
	closed_bets = db.get_closed_bets()

	return create_http_response()

