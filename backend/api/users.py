from flask import Flask, Blueprint
from db import db
from .api_utils import create_http_response

app = Flask(__name__)
users = Blueprint('users', __name__)


@users.route('/api/users/exist')
def check_user():
	log_user = request.args.get('loguser')
	auth = request.args.get('auth')
	auth_ = db.authenticate(log_user, auth)
	if not auth_:
		result = {}
		result['errors'] = []
		result['errors'].append('unauthenticated user')
		return create_http_response(data=result, errors=result['errors'])

	is_friend = request.args.get('friends')
	if is_friend:
		data = {}
		data['user_name'] = log_user
		all_friends = db.get_friends(data)

	else:
		


@users.route('/api/users/list')
def list_users():
	log_user = request.args.get('loguser')
	auth = request.args.get('auth')
	auth_ = db.authenticate(log_user, auth)
	if not auth_:
		result = {}
		result['errors'] = []
		result['errors'].append('unauthenticated user')
		return create_http_response(data=result, errors=result['errors'])

	user = db.get_users()

	return create_http_response()

@users.route('/api/users/find')
def get_user():
	log_user = request.args.get('loguser')
	auth = request.args.get('auth')
	auth_ = db.authenticate(log_user, auth)
	if not auth_:
		result = {}
		result['errors'] = []
		result['errors'].append('unauthenticated user')
		return create_http_response(data=result, errors=result['errors'])
	# TODO
	return create_http_response()


@users.route('/api/users/create')
def create_user():
	log_user = request.args.get('loguser')
	auth = request.args.get('auth')
	auth_ = db.authenticate(log_user, auth)
	if not auth_:
		result = {}
		result['errors'] = []
		result['errors'].append('unauthenticated user')
		return create_http_response(data=result, errors=result['errors'])
	#TODO

	return create_http_response()

