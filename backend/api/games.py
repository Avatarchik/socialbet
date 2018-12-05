from flask import Flask, Blueprint
from .api_utils import create_http_response
from flask import request
from db import db

app = Flask(__name__)
games = Blueprint('games', __name__)

@games.route('/api/games/')
def get_games():
    # TODO: create games json object and return it
    # check authentication
    log_user = request.args.get('loguser')
    auth_token = request.args.get('auth')
    authenticated = db.authenticate(log_user, auth_token)
    if not authenticated:
       return create_http_response(errors=['unauthenticated user'])

    # make query
    '''
    games = {
        'games': db.get_games()
    }
    '''
    # send GET request to api endpoint emulating gold standard sports api
    URL = 'http://socialbet.jpkrieg.com:5000/api/sports_api/'

    PARAMS = {}
    PARAMS['league'] = request.args.get('league')
    PARAMS['day'] = request.args.get('day')
    PARAMS['month'] = request.args.get('month')
    PARAMS['year'] = request.args.get('year')

    response = requests.get(url=URL, params=PARAMS)
    games = []
    for g in response:
        game = {}
        game['game_id'] = g['game_id']
        game['team1'] = g['HomeTeam']['fullName']
        game['team2'] =  g['AwayTeam']['fullName']
        game['team1_url'] = g['HomeTeam']['shortName']
        game['team2_url'] = g['AwayTeam']['shortName']
        game['game_time'] = g['eventStartsAt']
        game['home_score'] = g['homeScore']
        game['away_score'] = g['awayScore']
        games.append(game)

    print(games)   

    return create_http_response(data=games)

@games.route('/api/games/unnotified/')
def get_unnotified_games():

    log_user = request.args.get('loguser')
    auth_token = request.args.get('auth')
    authenticated = db.authenticate(log_user, auth_token)
    if not authenticated:
        return create_http_response(errors=['unauthenticated user'])

    games_to_notify = db.unnotified_bets(log_user)
    print("Right after the SQL query")
    print(games_to_notify)
    response = []
    return
