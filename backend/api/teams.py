from flask import Flask, Blueprint, send_from_directory
from .api_utils import create_http_response
from flask import request
from db import db

app = Flask(__name__)
teams = Blueprint('teams', __name__)

@teams.route('/team_logos/<path:path>')
def send_js(path):
    return send_from_directory('./team_logos/', path)

@teams.route('/api/teams/')
def get_teams():
    # TODO: create games json object and return it
    # check authentication
    log_user = request.args.get('loguser')
    auth_token = request.args.get('auth')
    authenticated = db.authenticate(log_user, auth_token)
    if not authenticated:
       return create_http_response(errors=['unauthenticated user'])

    # make query
    teams = {
        'teams': db.get_teams()
    }


    return create_http_response(data=teams)

