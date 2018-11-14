from flask import Flask, request, jsonify, Blueprint
from db import db
import json
from .api_utils import create_http_response

app = Flask(__name__)
betting = Blueprint('betting', __name__)


@betting.route('/api/betting/place_bet/', methods=['POST'])
def place_bet():
    '''
    Places a bet into the database, and returns success message
    :return:
    '''

    # Load request json data as dict
    data = json.loads(request.data)

    # Authenticate user
    loguser = data['loguser']
    auth = data['auth']
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])


    # Add bet to db
    bet_id = db.place_bet(data)

    # Send json response
    response_data = {
        'bet_id': bet_id
    }

    return create_http_response(data=response_data)

@betting.route('/api/betting/accept_bet/', methods=['POST'])
def accept_bet():
    '''
    Accepts bet

    :return:
    '''

    # Load request json data as dict
    data = json.loads(request.data)

    # Authenticate user
    loguser = data['loguser']
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # Accept bet
    bet_id = data['bet_id']
    other_user = data['other_user'] if 'other_user' in data else None
    db.accept_bet(bet_id, other_user)

    # Send json response
    return create_http_response()


@betting.route('/api/betting/cancel_bet/', methods=['POST'])
def cancel_bet():
    '''
    Cancel's a bet by
        1) Removing it from mysql database
        2) Cancelling smart contract
    :return:
    '''

    # Load request json data as dict
    data = json.loads(request.data)

    # Authenticate user
    loguser = data['loguser']
    auth = request.args.get('auth')
    if not db.authenticate(loguser, auth):
        return create_http_response(errors=['unauthenticated user'])

    # Accept bet
    bet_id = data['bet_id']
    db.cancel_bet(bet_id)

    # Send json response
    return create_http_response()
