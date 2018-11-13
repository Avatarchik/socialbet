from flask import Flask, request, jsonify, Blueprint
from db import db
import json
from .api_utils import create_http_response
import requests

app = Flask(__name__)
coinbase = Blueprint('coinbase', __name__)

@coinbase.route('/api/coinbase/connect/')
def connect():

	URL = 'https://www.coinbase.com/oauth/authorize'

	PARAMS = {}
	PARAMS['response_type'] = 'code'
	PARAMS['client_id'] = '73603a3ba3cda9f605b729ef9c0c57b08e90ca1ffedef1cfefad57003528e0c8'
	PARAMS['redirect_uri'] = '/api/coinbase/connect/'
	# OPTIONAL DONT THINK WE NEED THESE
	#PARAMS['state'] = 'SECURE_RANDOM'
	#PARAMS['scope'] = 'wallet:accounts:read'

	response = requests.get(url=URL, params=PARAMS)
	data = response.json()
	

	post_url = 'https://api.coinbase.com/oauth/token'
	post_params = {}
	post_params['grant_type'] = 'authorization_code'
	post_params['code'] = data['code']
	post_params['client_id'] = '73603a3ba3cda9f605b729ef9c0c57b08e90ca1ffedef1cfefad57003528e0c8'
	post_params['client_secret'] = 'b34e4e24b2faf7156ef86ccb3831fb15541834756f1ce84cf3066211d549240b'
	post_params['redirect_uri'] = '/api/coinbase/connect/'

	post_response = requests.post(url=post_url, params=post_params)
	post_data = post_response.json()

	# NOW SHOULD BE ABLE TO MAKE API CALLS TO COINBASE
	pass


@coinbase.route('/api/coinbase/send/')
def send_coinbase():

	pass

