from flask import Flask
import db
from .api_utils import create_http_response

app = Flask(__name__)

@app.route('/api/feeds/live_bets/')
def list_open_bets():
	direct = False
	accepted = False

	open_bets = db.get_bets(direct, accepted)

	result = {
		'bets': open_bets
	}

	return create_http_response(result)

@app.route('/api/feeds/closed_bets')
def list_closed_bets():
	direct = False
	accepted = False

	db_bets = db.get_bets(direct, accepted)

	bets = []
	for db_bet in db_bets:
		bet = db_bet

		db_user1 = db.get_user(db_bet['user1id'])
		user1 = {
			'user_id': db_user1['user_id'],
			'first_name': db_user1['first_name'],
			'last_name': db_user1['last_name'],
			'profile_pic_url': db_user1['profile_pic_url'],
			'team':
		}
		db_user2 = db.get_user(db_bet['user2id'])


	result = {
		'bets': open_bets
	}

	return create_http_response(result)

