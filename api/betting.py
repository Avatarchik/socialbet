from flask import Flask
from db import db

app = Flask(__name__)


@app.route('/api/betting/place_bet')
def place_bet():
	#todo: get bet information from HTTP request
	bet = None
	pass

@app.route('/api/betting/cancel_bet')
def cancel_bet():
	# todo: get bet information from HTTP request
	bet = None
	pass


