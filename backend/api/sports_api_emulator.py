from flask import Flask, request, jsonify, Blueprint
from db import db
import json
from .api_utils import create_http_response

app = Flask(__name__)
sports_api_emulator = Blueprint('sports_api_emulator', __name__)

@sports_api_emulator.route('/api/sports_api_emulator/')
def get_games_and_scores():

	log_user = request.args.get('loguser')
	auth_token = request.args.get('auth')
	authenticated = db.authenticate(log_user, auth_token)
	if not authenticated:
	   return create_http_response(errors=['unauthenticated user'])

	games = db.get_games()
	print(games)
	response = []
	for i in range(0,len(games)):
		game = {}
		game['game_id'] = games[i]['game_id']
		game['team1'] = games[i]['team1']
		game['team2'] = games[i]['team2']
		game['team1_url'] = games[i]['team1_url']
		game['team2_url'] = games[i]['team2_url']
		game['record1'] = games[i]['record1']
		game['record2'] = games[i]['record2']
		game['game_time'] = games[i]['game_time']
		game['homeScore'] = None
		game['awayScore'] = None
		game['eventStartsAt'] = None
		game['League'] = None
		game['AwayTeam'] = None
		game['HomeTeam'] = None
		response.append(game)

	return jsonify(response), 200,  {'ContentType': 'application/json'}