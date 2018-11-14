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

    account = cursor.fetchone()
    if account is not None:
        return True

    return False

########################## USERS ###########################################################
# I DONT NEED ANYTHING
def get_users():
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM users;"
    cursor.execute(sql)


    res = []
    for row in cursor:
        res.append(row)

    db.close()
    return res

# I NEED user_name
def get_user(user_name):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM users WHERE user_name = \"" + user_name + "\";"
    cursor.execute(sql)

    res = cursor.fetchone()

    db.close()

    return res

# I NEED ALL USER INFO
def create_user(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    username = str(data['username'])
    firstname = str(data['firstname'])
    lastname = str(data['lastname'])
    auth = str(data['auth'])
    phonenumber = str(data['phonenumber'])
    profile_pic_url = str(data['profile_pic_url'])

    print(username)
    print(firstname)
    print(lastname)
    print(auth)
    print(phonenumber)
    print(profile_pic_url)
    
    query = "INSERT INTO users VALUES ( '"+username+"', '"+firstname+"', '"+lastname+"', '"+phonenumber+"', '"+auth+"', '"+profile_pic_url+"' )"
    
    worked = True
    try:
        cursor.execute(query)
    except:
        worked = False
    
    if worked:
        db.commit()
    db.close()

    return worked

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
    cursor = db.cursor(pymysql.cursors.DictCursor)

    user_name = data['user_name']

    sql = "SELECT user2 FROM friends WHERE user1 = '" + user_name + "';"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

def add_friend(data):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()

    user1 = str(data['user1'])
    user2 = str(data['user2'])

    print('TESTING ADD_FRIENDS FUNCTION BETWEEN THE TWO USERS:')
    print(user1)
    print(user2)

    sql = "INSERT INTO friends VALUES ( '"+user1+"', '"+user2+"')"

    worked = True
    try:
        cursor.execute(sql)
    except:
        worked = False

    if worked:
        print('Successfully added friends ' + user1 + ' and ' + user2)
        db.commit()
    else:
        print('Failed adding friends ' + user1 + ' and ' + user2)

    db.close()

    return worked



########################## GAMES ###########################################################
def get_games():
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM games;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

########################## TEAMS ###########################################################
def get_teams():
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM teams;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res


########################## BETS ###########################################################
# THEY WILL PASS ME A USERID, I WILL RETURN ALL OF THE USERS BETS AND THE USERS FRIENDS BETS
# GET ONE FOR LIVE BETS AND ONE FOR OPEN BETS
def get_live_bets(loguser):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT B.* FROM bets B " \
          "INNER JOIN " \
            "(SELECT * FROM friends F1 WHERE F1.user1 =\"" + loguser + "\" OR F1.user2=\"" + loguser + "\") F2 " \
            "ON F2.user1 = B.user1 OR F2.user1 = B.user2 OR F2.user2 = B.user1 OR F2.user2 = B.user2 " \
           "WHERE accepted=1;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

def get_open_bets(loguser):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT B.* FROM bets B " \
          "INNER JOIN " \
            "(SELECT * FROM friends F1 WHERE F1.user1 =\"" + loguser + "\" OR F1.user2=\"" + loguser + "\") F2 " \
            "ON F2.user1 = B.user1 OR F2.user2 = B.user1 " \
           "WHERE accepted=0 AND direct=0;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res


def get_closed_bets(loguser):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT B.* FROM bets B " \
          "INNER JOIN " \
            "(SELECT * FROM friends F1 WHERE F1.user1 =\"" + loguser + "\" OR F1.user2=\"" + loguser + "\") F2 " \
            "ON F2.user1 = B.user1 OR F2.user1 = B.user2 OR F2.user2 = B.user1 OR F2.user2 = B.user2 " \
           "WHERE accepted=1 AND winner IS NOT NULL;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res


def get_pending_direct_bets(loguser):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM bets WHERE user2=\"" + loguser + "\" AND direct=1 AND accepted=0;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)

    db.close()

    return res


def get_bet_history(loguser):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM bets WHERE user1=\"" + loguser + "\" OR user2=\"" + loguser + "\" AND winner IS NOT NULL;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)

    db.close()

    return res


def get_between_us_bets(loguser, otheruser):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM bets " \
          "WHERE (user1=\"" + loguser + "\" AND user2=\"" + otheruser + "\")" \
          " OR" \
          "(user1=\"" + otheruser + "\" AND user2=\"" + loguser + "\");"

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
    cursor = db.cursor(pymysql.cursors.DictCursor)
    
    game_id = data['game_id']
    message = data['message']
    amount = data['amount']
    user1 = data['user1']
    user2 = data['user2']

    direct = data['direct']
    accepted = data['accepted']
    
    #Need to get gametime, team1, team2

    sql = "SELECT game_time, team1, team2 FROM games WHERE game_id = " + game_id + ";"
    cursor.execute(sql)
    row = cursor.fetchone()
    
    sql = "INSERT INTO bets VALUES ( NEWID()" + ", " + game_id + ", " + \
        "NOW(), " + row['game_time'] + ", " + \
        message + ", " + amount + ", " + user1 + ", "+ user2 + ", " + \
        row['team1'] + ", " + row['team2'] + ", " + direct + ", " + accepted + ");"

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

#I NEED ALL BET INFO
def get_bet(bet_id):

    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)
    sql = 'SELECT * FROM bets WHERE bet_id=' + str(bet_id) + ';'
    cursor.execute(sql)
    bet = cursor.fetchone()
    db.close()

    return bet

def accept_bet(bet_id, loguser):

    # Determine if direct or open bet
    bet = get_bet(bet_id)
    direct_bet = bet['direct']

    sql = 'UPDATE bets SET accepted=1'

    # open bet sql
    if not direct_bet:
        sql += ', user2=\"' + loguser + '\"'

    sql += ' WHERE bet_id=' + str(bet_id) + ';'

    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()
    db.close()

    return

def cancel_bet(bet_id):

    # Determine if direct or open bet

    sql = 'DELETE FROM bets WHERE bet_id=' + bet_id + ';'


    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()
    db.close()

    return

