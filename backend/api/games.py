from flask import Flask, Blueprint, url_for
from .api_utils import create_http_response
from flask import request
import requests
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
    #URL = 'http://socialbet.jpkrieg.com:5001/api/sports_api_emulator/'
    URL = 'http://localhost:5001' + url_for('sports_api_emulator.get_games_and_scores')
    print(URL)
    PARAMS = {}
    PARAMS['league'] = request.args.get('league')
    PARAMS['day'] = request.args.get('day')
    PARAMS['month'] = request.args.get('month')
    PARAMS['year'] = request.args.get('year')
    print(1)

    r = requests.get(url=URL, params=PARAMS, _external=False)
    print(2)
    print(r)
    response = r.json()
    print(response)
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


    bets_to_notify = db.unnotified_bets(log_user)
    response = []

    for db_bet in bets_to_notify:
        bet = db_bet
        db_user1 = db.get_user(db_bet['user1'])
        user1 = {
            'username': db_user1['user_name'],
            'first_name': db_user1['first_name'],
            'last_name': db_user1['last_name'],
            'profile_pic_url': db_user1['profile_pic_url'],
            'team': db_bet['team1']
        }
        db_user2 = db.get_user(db_bet['user2'])
        user2 = {
            'username': db_user2['user_name'],
            'first_name': db_user2['first_name'],
            'last_name': db_user2['last_name'],
            'profile_pic_url': db_user2['profile_pic_url'],
            'team': db_bet['team2']
        }

        bet['user1'] = user1
        bet['user2'] = user2
        response.append(bet)
        db.set_bet_to_notified(bet['bet_id'])

    # Return JSON response
    result = {
        'bets': response
    }

    return create_http_response(data=response)
