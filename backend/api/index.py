from flask import Flask, request, jsonify
import db
import json
from .api_utils import create_http_response

app = Flask(__name__)


@app.route('/', methods=['GET'])
def place_bet():
	'''
    SocialBet landing page
	'''

	return "Hello World!"


