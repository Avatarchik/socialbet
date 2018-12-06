from flask import Flask, Blueprint, request
from db import db
from .api_utils import create_http_response

app = Flask(__name__)
feeds = Blueprint('feeds', __name__)


@feeds.route('/api/feeds/open_bets_by_game/')
def list_open_bets_by_game():
    # Authenticate user
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    game_id = request.args.get('game_id')
    db_bets = db.get_open_bets(loguser)
    bets = []
    for bet in db_bets:
        if bet['game_id'] == game_id:
            db_user1 = db.get_user(bet['user1'])
            user1 = {
                'username': db_user1['user_name'],
                'first_name': db_user1['first_name'],
                'last_name': db_user1['last_name'],
                'profile_pic_url': db_user1['profile_pic_url'],
                'team': bet['team1']
            }
            bet['user1'] = user1
            if 'user2' in bet: del bet['user2']
            bets.append(bet)

    result = {
        'bets': bets
    }
    return create_http_response(data=result)


@feeds.route('/api/feeds/open_bets/')
def list_open_bets():

    # Authenticate user
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # Get open bets
    db_bets = db.get_open_bets(loguser)
    bets = []
    for db_bet in db_bets:
        bet = db_bet

        db_user1 = db.get_user(db_bet['user1'])
        user1 = {
            'username': db_user1['user_name'],
            'first_name': db_user1['first_name'],
            'last_name': db_user1['last_name'],
            'profile_pic_url': db_user1['profile_pic_url'],
            'team': db_bet['team1']
        }

        bet['user1'] = user1
        #bet['user2'] = None
        if 'user2' in bet: del bet['user2']

        bets.append(bet)


    # Return JSON response
    result = {
        'bets': bets
    }
    return create_http_response(data=result)

@feeds.route('/api/feeds/live_bets/')
def list_live_bets():

    # Authenticate user
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # Get live bets and construct JSON
    db_bets = db.get_live_bets(loguser)

    bets = []
    for db_bet in db_bets:
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
        bets.append(bet)

    # Return JSON response
    result = {
        'bets': bets
    }

    return create_http_response(data=result)



@feeds.route('/api/feeds/users_open_bets/')
def list_users_open_bets():

    # Authenticate user
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])
    username = request.args.get('username')

    # Get open bets
    db_bets = db.get_users_open_bets(username)
    bets = []
    for db_bet in db_bets:
        bet = db_bet

        db_user1 = db.get_user(db_bet['user1'])
        user1 = {
            'username': db_user1['user_name'],
            'first_name': db_user1['first_name'],
            'last_name': db_user1['last_name'],
            'profile_pic_url': db_user1['profile_pic_url'],
            'team': db_bet['team1']
        }

        bet['user1'] = user1
        #bet['user2'] = None
        if 'user2' in bet: del bet['user2']
        bets.append(bet)


    # Return JSON response
    result = {
        'bets': bets
    }
    return create_http_response(data=result)

@feeds.route('/api/feeds/users_live_bets/')
def list_users_live_bets():

    # Authenticate user
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])
    username = request.args.get('username')

    # Get live bets and construct JSON
    db_bets = db.get_users_live_bets(username)

    bets = []
    for db_bet in db_bets:
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
        bets.append(bet)

    # Return JSON response
    result = {
        'bets': bets
    }

    return create_http_response(data=result)



@feeds.route('/api/feeds/closed_bets/')
def list_closed_bets():
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    db_bets = db.get_closed_bets(loguser)

    bets = []
    for db_bet in db_bets:
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
        bets.append(bet)


    result = {
        'bets': bets
    }

    return create_http_response(data=result)


@feeds.route('/api/feeds/bet_history/')
def list_closed_bets_bet_history():
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # Get live bets and construct JSON
    db_bets = db.get_bet_history(loguser)

    bets = []
    for db_bet in db_bets:
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
        bets.append(bet)

    # Return JSON response
    result = {
        'bets': bets
    }

    return create_http_response(data=result)

@feeds.route('/api/feeds/direct_bets_pending/')
def list_direct_bets_pending():

    # Authenticate user
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # Get live bets and construct JSON
    db_bets = db.get_pending_direct_bets(loguser)

    bets = []
    for db_bet in db_bets:
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
        bets.append(bet)

    # Return JSON response
    result = {
        'bets': bets
    }

    return create_http_response(data=result)

@feeds.route('/api/feeds/between_us_bets/')
def list_between_us_bets():
    # Authenticate
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # Get bets and construct JSON
    other_user = request.args.get('user2')
    db_bets = db.get_between_us_bets(loguser, other_user)

    bets = []
    for db_bet in db_bets:
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
        bets.append(bet)

    # Return JSON response
    result = {
        'bets': bets
    }

    return create_http_response(data=result)
