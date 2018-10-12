from flask import Flask
from db import db

app = Flask(__name__)

@app.route('/api/feeds/open_bets/')
def list_open_bets():
	open_bets = db.get_open_bets()
	pass

@app.route('/api/feeds/closed_bets')
def list_closed_bets():
	closed_bets = db.get_closed_bets()
	pass

