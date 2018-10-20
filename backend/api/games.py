from flask import Flask

app = Flask(__name__)

@app.route('/api/games/get_games/')
def get_games():
	pass