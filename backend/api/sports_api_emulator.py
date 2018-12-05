from flask import Flask, Blueprint
from .api_utils import create_http_response
from flask import request
from db import db
import requests

app = Flask(__name__)
games = Blueprint('gold_std_sports_api_emulator', __name__)

# function is emulating gold standard sports api
# the api example can be found at: https://rapidapi.com/GoldStandard/api/gold-standard-sports
@gold_std_sports_api_emulator.route('/api/sports_api/')
def get_games_and_scores():

	log_user = request.args.get('loguser')
    auth_token = request.args.get('auth')
    authenticated = db.authenticate(log_user, auth_token)
    if not authenticated:
       return create_http_response(errors=['unauthenticated user'])

    games = db.get_games()
    response = []
    for g in games:
    	game = {}
    	game['game_id'] = g[0]
    	game['team1'] = g[1]
    	game['team2'] = g[2]
    	game['team1_url'] = g[3]
    	game['team2_url'] = g[4]
    	game['record1'] = g[5]
    	game['record2'] = g[6]
    	game['game_time'] = g[7]
    	game['homeScore'] = None
    	game['awayScore'] = None
    	game['eventStartsAt'] = None
    	game['League'] = None
    	game['AwayTeam'] = None
    	game['HomeTeam'] = None
    	response.append(game)

    return jsonify(response), 200,  {'ContentType': 'application/json'}