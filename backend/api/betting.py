from flask import Flask, request, jsonify
import db
import json
from .api_utils import create_http_response

app = Flask(__name__)


@app.route('/api/betting/place_bet', methods=['POST'])
def place_bet():
	'''
	Places a bet into the database, and returns success message
	:return:
	'''

	# Load request json data as dict
	data = json.loads(request.data)

	# TODO: Authenticate user
	pass


	# Insert bet into mysql db
	bet_id = db.place_bet(data)

	# Respond with bet id
	response_data = {
		'bet_id': bet_id
	}

	return create_http_response(data=response_data)

@app.route('/api/betting/accept_bet', methods=['POST'])
def accept_bet():
	'''
	Accepts bet

	:return:
	'''

	# Load request json data as dict
	data = json.loads(request.data)

	# TODO: Authenticate user
	pass


	# Insert bet into mysql db
	db.accept_bet(data)

	return create_http_response()


@app.route('/api/betting/cancel_bet', methods=['POST'])
def cancel_bet():
	'''
	Cancel's a bet by
		1) Removing it from mysql database
		2) Cancelling smart contract
	:return:
	'''

	# Load request json data as dict
	data = json.loads(request.data)
	bet_id = data

	# TODO: Authenticate user
	pass


	# Insert bet into mysql db
	db.cancel_bet(bet_id)

	# Respond with status
	return create_http_response()

