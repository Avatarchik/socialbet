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

### Root level directory
```
.
├── API_Spec.md
├── backend
├── frontend
├── readme.md
└── starterapp
```

The root level directory splits up the project into three main directories:

- `/backend/`: backend implementation run on our digitalocean server
- `/frontend/`: front end iOS code written in swift
- `/starterapp/`: the genesis of our project began with building a starter app, which is contained therein

Additionally, this root level directory contains *two* markdown files:
- `API_Spec.md`: the outline of backend architecture. This contains all of the endpoints our backend implements, the data they expect and the json they output.
- `readme.md`: this file that you are currently reading from _(yeah, we just broke the fourth wall)_


# Backend

## `/backend/` Directory Structure
```
├── __init__.py
├── api
│   ├── api_utils.py
│   ├── betting.py
│   ├── coinbase.py
│   ├── feeds.py
│   ├── games.py
│   ├── index.py
│   ├── teams.py
│   └── users.py
├── app.py
├── build
│   └── lib
│       └── api
│           ├── api_utils.py
│           ├── betting.py
│           ├── coinbase.py
│           ├── feeds.py
│           ├── games.py
│           ├── index.py
│           └── users.py
├── config.py
├── db
│   ├── data.sql
│   ├── db.py
│   ├── db_config.py
│   ├── delete.sql
│   ├── drop.sql
│   ├── reload.sql
│   └── schema.sql
├── run_server.sh
├── setup.py
├── smart-contract
│   └── SocialBetSmartContract.sol
├── test_script.sh
└── wsgi.py
```
_6 directories, 30 files_

This `backend` directory contains several directories of interest:

- `/api/`: The module containing all of our backend endpoints
- `/db/`: The directory containing all of our sql database scripts, as well as `db.py`, which implements the interface between our backend and our mysql database.
-`/smart-contract/`: The directory containing our Ethereum smart contract (`SocialBetSmartContract.sol`) which handles the distribution of bet payouts.

Additionally, this directory contains some key files for the backend

- `app.py`: This is the file which actually startups the flask server. `gunicorn` uses this file to serve api endpoints.
- `config.py`: This file contains server configuration information
- `run_server.sh`: This is a bash script which starts up the flask server using `gunicorn`
- `test_script.sh`: This bash script contains a **myriad** of test functions which use `curl` with the proper HTTP headers and parameters to test out endpoints. Read "Testing Endpoints" for more on how to use this script.


## Running The Backend Server
This step is still very nebular. We will update this with database, web serving, frontend building, and all other kinds of instructions to get someone started with our app.

1. **SSH into server**

    `ssh root@socialbet.jpkrieg.com`

    **NOTE**: ask for password if you don't have it

2. **Change into backend directory**

    `cd ~/socialbet/backend`

3. **Run flask app with guincorn**

    `gunicorn --bind 0.0.0.0:5000 app:app --log-level=debug`
    
    _OR_
    
    `./run_server.sh`

    Now, you should be able to make requests. Make sure to send requests to port 5000.

****Example Request****

`curl -X GET http://165.227.180.80:5000/api/feeds/live_bets/`

## Testing Endpoints
To test endpoints, the backend directory contains a handy testing bash script: `backend/test_script.sh`.

_Note: Before testing an endpoint, make sure the backend server is running on digital ocean (refer to above section: "Running the Backend")._

`test_script.sh` takes in exactly *one* argument, which specifies which endpoint you would like to test.

****Example Request****
`./test_script.sh open_bets`

will return json that looks like.

`{"bets":[{"accepted":0,"ammount":50.0,"bet_id":5,"direct":1,"game_id":3,"game_time":"11/18/2018 1:00PM","message":"This is just easy money","num_comments":0,"team1":"Pittsburgh Steelers","team2":"Jacksonville Jaguars","time_placed":"11/13/2018 3:52PM","user1":{"first_name":"Chris","last_name":"Terech","profile_pic_url":"/root/socialbet/backend/user_profile_pics/terech.png","team":"Pittsburgh Steelers","user_id":"cterech"},"user2":{"first_name":"Ittai","last_name":"Svilder","profile_pic_url":"/root/socialbet/backend/user_profile_pics/svidler.png","team":"Jacksonville Jaguars","user_id":"isvidler"},"winner":"isvidler"},{"accepted":0,"ammount":9.0,"bet_id":24,"direct":1,"game_id":3,"game_time":"11/18/2018 1:00PM","message":"fuck yeah test worked","num_comments":0,"team1":"Pittsburgh Steelers","team2":"Jacksonville Jaguars","time_placed":"this is a date","user1":{"first_name":"Ittai","last_name":"Svilder","profile_pic_url":"/root/socialbet/backend/user_profile_pics/svidler.png","team":"Pittsburgh Steelers","user_id":"isvidler"},"user2":{"first_name":"Chris","last_name":"Terech","profile_pic_url":"/root/socialbet/backend/user_profile_pics/terech.png","team":"Jacksonville Jaguars","user_id":"cterech"},"winner":null}],"errors":[],"success_status":"successful"}`

As we can see, this endpoint works. Simultaneously, you should be monitoring the terminal window which is running the server on digital ocean, to see if it provides any interesting feedback.


# Frontend

## `/frontend/` Directory Structure

The real magic happens in the `/frontend/SocialBet/SocialBet` directory.
Its directory structure is shown below.

```
.
├── AppDelegate.swift
├── BetBuilderGameSelection.swift
├── BetBuilderOpponentSelection.swift
├── BetBuilderTeamSelection.swift
├── BetBuilderTeamSelection.swift.orig
├── Bridging-Header.h
├── ClosedFeedCell.swift
├── ClosedFeedCell.xib
├── Common.swift
├── Common.swift.orig
├── Feed.swift
├── GamesFeedCell.swift
├── GamesFeedCell.xib
├── Info.plist
├── LiveFeedCell.swift
├── LiveFeedCell.xib
├── Login.swift
├── MyBets.swift
├── OpenFeedCell.swift
├── OpenFeedCell.xib
├── Profile.swift
├── Registration.swift
├── Registration.swift.orig
├── Settings.swift
├── SideMenu.swift
├── UserLogin.swift
├── accept.png
├── decline.png
├── defaultProfilePic.png
└── networking.swift
```

Interesting files:

- `*Cell.xib`: All files ending in this format are the visual frontend implementations for the individual cells for the feeds.
- `*Cell.swift`: All files ending in this format contain the logic for the corresponding `*Cell.xib` files
- `Profile.swift`: ViewController containing main profile view for a user
- `Feed.swift`: ViewController containing feeds for the user. This implements *all* the feeds.
- `MyBets.swift`: ViewController containing all of the user's own bets.
- `Login.swift`: ViewController for user login.
- `Registration.swift` ViewController for user account registration.
- `Bridging-Header.h`: Allows us to hash password



## Building and Running the iOS Application

Open the application in XCode. Hit the "Play button" in the top left corner of xcode to run the application. Make sure you select `iPhone 5s` as the simulated device.
Make sure the backend server is running (See "Running the Backend Server") on digital ocean.

## Testing the iOS Application
To test the iOS application, make sure the backend server is running (See "Running the Backend Server") on digital ocean.
Then, testing the application is intuitive. Build and run the iOS application in XCode (see "Building and Running the iOS Application" section above)
and try using every feature.

You should monitor two things to ensure proper function:
- The iOS application works as expected
- The server running on digital ocean does not encounter any internal errors