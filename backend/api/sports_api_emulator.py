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
	response = []
	for i in range(0,len(games)):
		game = {}
		game['game_id'] = g[i][0]
		game['team1'] = g[i][1]
		game['team2'] = g[i][2]
		game['team1_url'] = g[i][3]
		game['team2_url'] = g[i][4]
		game['record1'] = g[i][5]
		game['record2'] = g[i][6]
		game['game_time'] = g[i][7]
		game['homeScore'] = None
		game['awayScore'] = None
		game['eventStartsAt'] = None
		game['League'] = None
		game['AwayTeam'] = None
		game['HomeTeam'] = None
		response.append(game)

	return jsonify(response), 200,  {'ContentType': 'application/json'}