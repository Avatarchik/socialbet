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
    auth = request.args.get('auth')
    auth_ = db.authenticate(log_user, auth)
    if not auth_:
       result = {}
       result['errors'] = []
       result['errors'].append('unauthenticated user')
       return create_http_response(data=result, errors=result['errors'])

    # make query
    games = {
        'games': db.get_games()
    }


    return create_http_response(data=games)

