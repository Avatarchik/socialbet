from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/', methods=['GET'])
def place_bet():
	'''
    SocialBet landing page
	'''

	return "Hello World!"


