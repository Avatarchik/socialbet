# from flask import Flask, request, jsonify, Blueprint
# from db import db
# from .api_utils import create_http_response
# import requests
# from coinbase.wallet.client import Client # FIXME: think we need this right?
# import random
# import string
# import urllib
import requests
import json
#
#
# app = Flask(__name__)
# coinbase = Blueprint('coinbase', __name__)
#
# @coinbase.route('/api/coinbase/connect/')
# def connect():
#
#     # FIXME: is this only for web apps?
#     URL = 'https://www.coinbase.com/oauth/authorize'
#
#     PARAMS = {}
#     PARAMS['response_type'] = 'code'
#     PARAMS['client_id'] = '73603a3ba3cda9f605b729ef9c0c57b08e90ca1ffedef1cfefad57003528e0c8'
#     PARAMS['redirect_uri'] = '/api/coinbase/connect/'
#     # OPTIONAL DONT THINK WE NEED THESE
#     #PARAMS['state'] = 'SECURE_RANDOM'
#     #PARAMS['scope'] = 'wallet:accounts:read'
#
#     response = requests.get(url=URL, params=PARAMS)
#     data = response.json()
#
#
#     post_url = 'https://api.coinbase.com/oauth/token'
#     post_params = {}
#     post_params['grant_type'] = 'authorization_code'
#     post_params['code'] = data['code']
#     post_params['client_id'] = '73603a3ba3cda9f605b729ef9c0c57b08e90ca1ffedef1cfefad57003528e0c8'
#     post_params['client_secret'] = 'b34e4e24b2faf7156ef86ccb3831fb15541834756f1ce84cf3066211d549240b'
#     post_params['redirect_uri'] = '/api/coinbase/connect/'
#
#     post_response = requests.post(url=post_url, params=post_params)
#     post_data = post_response.json()
#
#     # NOW SHOULD BE ABLE TO MAKE API CALLS TO COINBASE
#     pass
#
#
# @coinbase.route('/api/coinbase/send/', methods=['POST'])
# def send_coinbase():
#     data = json.loads(request.data)
#     usd_amt = data['amount']
#
#     exc = (urllib.request.urlopen("https://api.coinbase.com/v2/prices/ETH-USD/buy").read()).decode("utf-8")
#     exchange_rate = json.loads(exc)["data"]
#     print(exchange_rate)
#
#     eth_amt = exchange_rate * usd_amt
#     # FIXME: need to do this for both users involved in bet
#     # is it this exact url?
#     URL = 'https://api.coinbase.com/v2/accounts/:account_id/transactions'
#     PARAMS = {}
#     PARAMS['type'] = 'send'
#     PARAMS['to'] = 'FIXME:need ETH wallet addr here'
#     PARAMS['amount'] = str(eth_amt)
#     PARAMS['currency'] = 'ETH'
#     # making random idem string for each transaction
#     s = string.lowercase + string.digits
#     PARAMS['idem'] = ''.join(random.sample(s,100))
#     PARAMS['to_financial_institution'] = False
#
#     response = requests.post(url=URL, params=PARAMS)
#     pass
#
#
#
#
#
#

def fetch_users_auth_token(code):
    data = {'grant_type': 'authorization_code',
            'code': code,
            'client_id': client_id,
            'client_secret': client_secret,
            'redirect_uri': ''}

    api_url = 'https://api.coinbase.com/oauth/token'

    r = requests.post(url=api_url, data=data)

    response_data = json.loads(r.text)

    return {'access_token': response_data['access_token'], 'refresh_token': response_data['refresh_token']}
