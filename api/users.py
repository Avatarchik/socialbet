from flask import Flask
from db import db

app = Flask(__name__)

@app.route('/api/users/list')
def list_users():
	user = db.get_users()
	pass

@app.route('/api/users/find')
def get_user():
	pass

@app.route('/api/users/create')
def create_user():
	pass

