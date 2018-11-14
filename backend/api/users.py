from flask import Flask, Blueprint, request
from werkzeug.datastructures import ImmutableMultiDict
from db import db
from .api_utils import create_http_response
import json

app = Flask(__name__)
users = Blueprint('users', __name__)

#Currently a bug in this endpoint. Returning no friends with achapp and cterech
@users.route('/api/users/exist/')
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
def get_user():
    log_user = request.args.get('loguser')
    auth = request.args.get('auth')
    auth_ = db.authenticate(log_user, auth)
    if not auth_:
        result = {}
        result['errors'] = []
        result['errors'].append('unauthenticated user')
        return create_http_response(data=result, errors=result['errors'])
    
    result = {}
    data = {}
    data['user_name'] = request.args.get('username')
    users = db.get_user(data)
    if len(users) == 0:
        result = {}
        result['errors'] = []
        result['errors'].append('username does not exist')
        return create_http_response(data=result, errors=result['errors'])
    elif len(users) > 1:
        result = {}
        result['errors'] = []
        result['errors'].append('multiple identical usernames found')
        return create_http_response(data=result, errors=result['errors'])

    result['username'] = users[0]['user_name']
    result['first_name'] = users[0]['first_name']
    result['last_name'] = users[0]['last_name']
    result['profile_pic_url'] = users[0]['profile_pic_url']

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
    data = json.loads(request.args)
    username = data['username']
    auth = data['auth']
    auth_ = db.authenticate(username, auth)
    if not auth_:
        result = {}
        result['errors'] = []
        result['errors'].append('username and auth dont match up')
        return create_http_response(data=result, errors=result['errors'])
    
    return create_http_response()

