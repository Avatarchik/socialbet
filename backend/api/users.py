from flask import Flask, Blueprint
from db import db
from .api_utils import create_http_response

app = Flask(__name__)
users = Blueprint('users', __name__)


@users.route('/api/users/list')
def list_users():
	# TODO

	user = db.get_users()

	return create_http_response()

@users.route('/api/users/find')
def get_user():

	# TODO
	return create_http_response()


@users.route('/api/users/create')
def create_user():

	#TODO

	return create_http_response()

