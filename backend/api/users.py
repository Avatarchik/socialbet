from flask import Flask, Blueprint, request, send_from_directory
from werkzeug.datastructures import ImmutableMultiDict
from db import db
from .api_utils import create_http_response
import json

app = Flask(__name__)
users = Blueprint('users', __name__)


@users.route('/user_profile_pics/<path:path>')
def send_user_photo(path):
    return send_from_directory('user_profile_pics/', path)

#Currently a bug in this endpoint. Returning no friends with achapp and cterech
@users.route('/api/users/exist/')
def check_user():
    # Authenticate user
    log_user = request.args.get('loguser')
    auth = request.args.get('auth')
    auth_ = db.authenticate(log_user, auth)
    if not auth_:
        result = {}
        result['errors'] = []
        result['errors'].append('unauthenticated user')
        return create_http_response(data=result, errors=result['errors'])

    #
    is_friend = request.args.get('friends')
    response = {}
    if is_friend:
        data = {}
        data['user_name'] = log_user
        all_friends = db.get_friends(data)
        count = 0
        for friend in all_friends:
            if friend == request.args.get('username'):
                break
            count += 1
        if count == len(all_friends):
            response['value'] = False
        else:
            response['value'] = True
    else:
        data = {}
        data['user_name'] = request.args.get('username')
        response['value'] = db.user_exist(data)

    return create_http_response(data=response)


@users.route('/api/users/find/')
def find_user():
    log_user = request.args.get('loguser')
    auth = request.args.get('auth')
    auth_ = db.authenticate(log_user, auth)
    if not auth_:
        result = {}
        result['errors'] = []
        result['errors'].append('unauthenticated user')
        return create_http_response(data=result, errors=result['errors'])
    
    result = {}
    username = request.args.get('username')
    user = db.get_user(username)

    if not user:
        result = {}
        result['errors'] = []
        result['errors'].append('username does not exist')
        return create_http_response(data=result, errors=result['errors'])

    result['username'] = user['user_name']
    result['first_name'] = user['first_name']
    result['last_name'] = user['last_name']
    result['profile_pic_url'] = user['profile_pic_url']
    result['friends'] = db.are_friends(log_user, username)

    return create_http_response(data=result)

@users.route('/api/users/find_user_id/')
def find_user():
    log_user = request.args.get('loguser')
    auth = request.args.get('auth')
    auth_ = db.authenticate(log_user, auth)
    if not auth_:
        result = {}
        result['errors'] = []
        result['errors'].append('unauthenticated user')
        return create_http_response(data=result, errors=result['errors'])
    
    result = {}
    username = request.args.get('user_id')
    user = db.get_user_id(user_id)

    if not user:
        result = {}
        result['errors'] = []
        result['errors'].append('username does not exist')
        return create_http_response(data=result, errors=result['errors'])

    result['user_id'] = user['user_id']
    result['username'] = user['user_name']
    result['first_name'] = user['first_name']
    result['last_name'] = user['last_name']
    result['profile_pic_url'] = user['profile_pic_url']
    result['friends'] = db.are_friends(log_user, username)

    return create_http_response(data=result)


@users.route('/api/users/create/', methods=["POST"])
def create_user():

    data = json.loads(request.data)
    
    user_info = {}
    user_info['username'] = data['username']
    user_info['auth'] = data['auth']
    user_info['firstname'] = data['firstname']
    user_info['lastname'] = data['lastname']
    user_info['phonenumber'] = data['phonenumber']
    user_info['profile_pic_url'] = data['profile_pic_url']

    worked = db.create_user(user_info)
    if worked:
        return create_http_response()
    else:
        result = {}
        result['errors'] = []
        result['errors'].append("Error Occurred")
        return create_http_response(data=result, errors=result['errors'])


@users.route('/api/users/login/', methods=["POST"])
def login_user():
    data = json.loads(request.data)
    username = data['username']
    auth = data['auth']
    auth_ = db.authenticate(username, auth)
    if not auth_:
        result = {}
        result['errors'] = []
        result['errors'].append('username and auth dont match up')
        return create_http_response(data=result, errors=result['errors'])
    
    return create_http_response()

@users.route('/api/users/add_friend/', methods=["POST"])
def add_friend():
    data = json.loads(request.data)
    info = {}

    info['loguser'] = data['loguser']
    info['auth'] = data['auth']
    auth_ = db.authenticate(info['loguser'], info['auth'])
    if not auth_:
        result = {}
        result['errors'] = []
        result['errors'].append('unauthenticated user')
        return create_http_response(data=result, errors=result['errors'])
    info['user1'] = data['user1']
    info['user2'] = data['user2']

    worked = db.add_friend(info)
    if worked:
        return create_http_response()
    else:
        result = {}
        result['errors'] = []
        result['errors'].append("Error Occurred")
        return create_http_response(data=result, errors=result['errors'])
