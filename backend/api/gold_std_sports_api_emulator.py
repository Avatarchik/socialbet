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

	pass