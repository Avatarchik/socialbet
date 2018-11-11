from flask import Flask, Blueprint
from db import db
from .api_utils import create_http_response

app = Flask(__name__)
feeds = Blueprint('feeds', __name__)


@feeds.route('/api/feeds/open_bets/')
def list_open_bets():
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
			'team': db_bet['user1team']
		}

		bet['user1'] = user1
		bets.append(bet)


	result = {
		'bets': bets
	}
	return create_http_response(result)

@feeds.route('/api/feeds/live_bets/')
def list_closed_bets():
	direct = True
	accepted = True

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
			'team': db_bet['user1team']
		}
		db_user2 = db.get_user(db_bet['user2id'])
		user2 = {
			'user_id': db_user2['user_id'],
			'first_name': db_user2['first_name'],
			'last_name': db_user2['last_name'],
			'profile_pic_url': db_user2['profile_pic_url'],
			'team': db_bet['user2team']
		}

		bet['user1'] = user1
		bet['user2'] = user2
		bets.append(bet)


	result = {
		'bets': bets
	}

	return create_http_response(result)

@feeds.route('/api/feeds/direct_bets_pending')
def list_direct_bets_pending():
	pass

@feeds.route('/api/feeds/past_bets')
def list_past_bets():
	direct = True
	accepted = True


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
			'team': db_bet['user1team']
		}
		db_user2 = db.get_user(db_bet['user2id'])
		user2 = {
			'user_id': db_user2['user_id'],
			'first_name': db_user2['first_name'],
			'last_name': db_user2['last_name'],
			'profile_pic_url': db_user2['profile_pic_url'],
			'team': db_bet['user2team']
		}

		bet['user1'] = user1
		bet['user2'] = user2
		bets.append(bet)


	result = {
		'bets': bets
	}

	return create_http_response(result)

