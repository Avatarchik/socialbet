from .db_config import get_db_config
import pymysql

def authenticate(log_user, auth):
    if log_user is None or auth is None:
        return False

    # check to see if this {username, auth} tuple is in the db
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()
   
    sql = "SELECT user_name FROM users WHERE user_name=\"" + log_user + "\" AND auth=\"" + auth + "\";"
    cursor.execute(sql)

    account = cursor.fetch_one()
    if account is not None:
        return True

    return False

########################## USERS ###########################################################
# I DONT NEED ANYTHING
def get_users():
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    sql = "SELECT * FROM users;"
    cursor.execute(sql)


    res = []
    for row in cursor:
        res.append(row)

    db.close()
    return res

# I NEED user_name
def get_user(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    user_name = data['user_name']

    sql = "SELECT * FROM users WHERE user_name = " + user_name + ";"
    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)

    db.close()

    return res

# I NEED ALL USER INFO
def create_user(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()


    user_name = data['user_name']
    first_name = data['first_name']
    last_name = data['last_name']
    auth = data['auth']
    phone = data['phone']
    prof_pic = data['prof_pic']
    sql = "INSERT INTO users VALUES ( " + user_name + ", " + first_name + ", " + last_name + ", " + \
        phone + ", " + auth + ", " + prof_pic ");"

    cursor.execute(sql)
    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

# I NEED ONLY user_name
def drop_user(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    user_name = data['user_name']
    sql = "DELETE FROM users WHERE user_name = " + user_name + ";"

    cursor.execute(sql)
    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

########################## FRIENDS ###########################################################
# I NEED user_name ONLY
# WE ARE SHIFTING OVER TO USING USERNAME AS IDENTIFIER
def get_friends(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    user_name = data['user_name']

    sql = "SELECT user2 FROM friends WHERE user1 = " + user_name + ";"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

########################## GAMES ###########################################################
def get_games():
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    sql = "SELECT * FROM games;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

########################## BETS ###########################################################
# THEY WILL PASS ME A USERID, I WILL RETURN ALL OF THE USERS BETS AND THE USERS FRIENDS BETS
# GET ONE FOR LIVE BETS AND ONE FOR OPEN BETS
def get_live_bets(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    user_name = data['user_name']

    sql = "SELECT * FROM bets WHERE user1 = (SELECT user2 FROM friends WHERE user1 = " + user_name + " " + ") AND accepted=1;"
    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

def get_open_bets(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    user_name = data['user_name']

    sql = "SELECT * FROM bets WHERE user1 = (SELECT user2 FROM friends WHERE user1 = " + user_name + " " + ") AND accepted=0;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

# I NEED ALL BET INFO
# JUST GETTING TWO TEAMS
def place_bet(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    time_placed = data['time_placed']
    game_time = data['game_time']
    message = data['message']
    amount = data['amount']
    user1 = data['user1']
    user2 = data['user2']
    team1 = data['team1']
    team2 = data['team2']

    direct = data['direct']
    accepted = data['accepted']

    sql = "SELECT game_id FROM games WHERE team1 = " + team1 + " AND team2 = " + team2  + ";"
    cursor.execute(sql)
    game_id = cursor.fetchall()

    sql = "INSERT INTO bets VALUES ( NEWID()" + ", " + game_id + ", " + \
        time_placed + ", " + game_time + ", " + \
        message + ", " + amount + ", " + user1 + ", "+ user2 + ", " + \
        team1 + ", " + team2 + ", " + direct + ", " + accepted + ");"

    cursor.execute(sql)
    db.close()

    return

# Returns True if count(user_name) > 0 otherwise false
def user_exist(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()
    user_name = data['user_name']
    sql = "SELECT user_name FROM users WHERE user_name = " + user_name

    cursor.execute(sql)

    count = cursor.fetchone()
    if count is not None:
        return True
    else:
        return False

# I NEED ALL BET INFO
# JUST GETTING TWO TEAMS
def place_bet(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    time_placed = data['time_placed']
    game_time = data['game_time']
    message = data['message']
    amount = data['amount']
    user1 = data['user1']
    user2 = data['user2']
    team1 = data['team1']
    team2 = data['team2']

    direct = data['direct']
    accepted = data['accepted']

    sql = "SELECT game_id FROM games WHERE team1 = " + team1 + " AND team2 = " + team2  + ";"
    cursor.execute(sql)
    game_id = cursor.fetchall()

    sql = "INSERT INTO bets VALUES ( NEWID()" + ", " + game_id + ", " + \
        time_placed + ", " + game_time + ", " + \
        message + ", " + amount + ", " + user1 + ", "+ user2 + ", " + \
        team1 + ", " + team2 + ", " + direct + ", " + accepted + ");"

    cursor.execute(sql)
    db.close()

    return

def get_bet(bet_id):

    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()
    sql = 'SELECT * FROM bets WHERE bet_id=\"' + bet_id+ '\";'
    cursor.execute(sql)
    bet = cursor.fetchone()
    db.close()

    return bet

def accept_bet(data):
    bet_id = data['bet_id']
    user_name = data['user_name']

    # Determine if direct or open bet
    bet = get_bet(bet_id)
    direct_bet = bet['direct']

    sql = 'UPDATE bets SET accepted=1'

    # open bet sql
    if not direct_bet:
        sql += ', user2=\"' + user_name + '\"'

    sql += ' WHERE bet_id=' + bet_id+ ';'

    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()
    cursor.execute(sql)
    db.close()

    return

