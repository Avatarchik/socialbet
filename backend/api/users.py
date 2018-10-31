from flask import Flask
import db
from .api_utils import create_http_response

app = Flask(__name__)

@app.route('/api/users/list')
def list_users():
	# TODO

	user = db.get_users()

	return create_http_response()

@app.route('/api/users/find')
def get_user():

	# TODO
	return create_http_response()


@app.route('/api/users/create')
def create_user():

	#TODO

	return create_http_response()

