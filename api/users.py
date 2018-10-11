from flask import Flask
from db import db

app = Flask(__name__)

@app.route('/api/get_users')
def get_users():
	user = db.get_users()
	pass