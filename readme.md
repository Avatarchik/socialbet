# SocialBet

## Team
- Alexander Chapp
- Chris Terech
- Ittai Svidler
- John Krieg
- Nick Cargill
- Ryan Shelly
- Trevor Swartz

## Directory Contents
Readme: what you are currently reading
- /backend/: backend implementation run on our digitalocean server
- /frontend/: front end iOS code written in swift
- /starterapp/: the genesis of our project began with building a starter app, which is contained therein

## Running The Server
This step is still very nebular. We will update this with database, web serving, frontend building, and all other kinds of instructions to get someone started with our app.

1. **SSH into server**

    `ssh root@socialbet.jpkrieg.com`

    **NOTE**: ask for password if you don't have it

2. **Change into backend directory**

    `cd ~/socialbet/backend`

3. **Run flask app with guincorn**

    `gunicorn --bind 0.0.0.0:5000 app:app --log-level=debug`

    Now, you should be able to make requests. Make sure to send requests to port 5000.

****Example Request****

`curl -X GET http://165.227.180.80:5000/api/feeds/live_bets/`

