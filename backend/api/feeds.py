from flask import Flask, Blueprint, request
from db import db
from .api_utils import create_http_response

app = Flask(__name__)
feeds = Blueprint('feeds', __name__)


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


    # Return JSON response
    result = {
        'bets': bets
    }
    return create_http_response(data=result)

@feeds.route('/api/feeds/live_bets/')
def list_closed_live_bets():

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

    # Return JSON response
    result = {
        'bets': bets
    }

    return create_http_response(data=result)


@feeds.route('/api/feeds/closed_bets')
def list_closed_bets():
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    db_bets = db.get_closed_bets(loguser)

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

    return create_http_response(data=result)


@feeds.route('/api/feeds/bet_history')
def list_closed_bets_bet_history():
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # TODO
    # Note: major problem here will be adding bet users to the proper bets
    pass


@feeds.route('/api/feeds/direct_bets_pending')
def list_direct_bets_pending():
    loguser = request.args.get('loguser')
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # TODO

    pass

