from .db_config import get_db_config
import pymysql
import datetime

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

def find_id(user_id):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM users WHERE user_id = \"" + user_id + "\";"
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
    private_key = str(data['private_key'])
    public_key = str(data['public_key'])

    print(username)
    print(firstname)
    print(lastname)
    print(auth)
    print(phonenumber)
    print(profile_pic_url)
    print(private_key)
    
    query = "INSERT INTO users VALUES ( '"+username+"', '"+firstname+"', '"+lastname+"', '"+phonenumber+"', '"+auth+"', '"+profile_pic_url +"', '"+ private_key + "', '" + public_key + "')"
    
    print(query)
    
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

def are_friends(loguser, user2):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)


    sql = "SELECT * FROM friends WHERE (user1=\"" + loguser + "\" AND user2=\"" + user2 + "\") " \
          "OR " \
          "(user2=\"" + loguser + "\" AND user1=\"" + user2 + "\");"

    cursor.execute(sql)

    res = cursor.fetchone()

    db.close()

    return True if res else False

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

def get_game(game_id):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT * FROM games WHERE game_id=" + game_id + ";"

    cursor.execute(sql)

    res = cursor.fetchone()

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

    sql = "SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B " \
          "INNER JOIN " \
            "(SELECT * FROM friends F1 WHERE F1.user1 =\"" + loguser + "\" OR F1.user2=\"" + loguser + "\") F2 " \
            "ON F2.user1 = B.user1 OR F2.user1 = B.user2 OR F2.user2 = B.user1 OR F2.user2 = B.user2 " \
           "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
            "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
            "WHERE accepted=1 AND winner IS NULL ORDER BY B.bet_id DESC;"

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

    sql = "SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B " \
          "INNER JOIN " \
            "(SELECT * FROM friends F1 WHERE F1.user1 =\"" + loguser + "\" OR F1.user2=\"" + loguser + "\") F2 " \
            "ON F2.user1 = B.user1 OR F2.user2 = B.user1 " \
            "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
            "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
           "WHERE accepted=0 AND direct=0 AND winner IS NULL ORDER BY B.bet_id DESC;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

def get_users_live_bets(loguser):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B "\
        "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
          "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
            "WHERE winner IS NULL AND accepted=1 AND (user1=\"" + loguser + "\" OR user2=\"" +  loguser + " \") ORDER BY bet_id DESC;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)


    db.close()

    return res

def get_users_open_bets(loguser):
    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)
    sql="SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B "\
        "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
          "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
            "WHERE winner IS NULL AND accepted=0 AND direct=0 AND user1=\"" + loguser +  "\";"
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

    sql = "SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B "\
          "INNER JOIN " \
            "(SELECT * FROM friends F1 WHERE F1.user1 =\"" + loguser + "\" OR F1.user2=\"" + loguser + "\") F2 " \
            "ON F2.user1 = B.user1 OR F2.user1 = B.user2 OR F2.user2 = B.user1 OR F2.user2 = B.user2 " \
            "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
          "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
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

    sql = "SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B "\
        "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
          "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
            "WHERE user2=\"" + loguser + "\" AND direct=1 AND accepted=0;"

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

    sql = "SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B "\
        "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
          "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
        "WHERE (user1=\"" + loguser + "\" OR user2=\"" + loguser + "\") AND B.winner IS NOT NULL;"


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

    sql = "SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B "\
        "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
          "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
          "WHERE ((user1=\"" + loguser + "\" AND user2=\"" + otheruser + "\")" \
          " OR" \
          "(user1=\"" + otheruser + "\" AND user2=\"" + loguser + "\")) AND winner IS NOT NULL;"

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)

    db.close()

    return res

# I NEED ALL BET INFO
# JUST GETTING TWO TEAMS
def place_bet(data):

    game_id = str(data['game_id'])
    message = data['message']
    amount = str(data['amount'])
    direct = str(data['direct'])
    user1 = data['user1']
    if direct:
        user2 = data['user2']
    else:
        user2 = None
    team1 = data['team1']
    team2 = data['team2']
    time_placed = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")

   
    accepted = str(data['accepted'])

    game = get_game(game_id)

    game_time = str(game['game_time'])

    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    

    sql = "INSERT INTO bets " \
          "(time_placed, game_id, game_time, message, ammount, user1, user2, team1, team2, direct, accepted) " \
          "VALUES " \
          "(\"" + time_placed + "\", " +  game_id + ", \"" + game_time + "\", \"" + message + "\", " + amount + ", \"" + user1 + "\", \"" + user2 + \
          "\", \"" + team1 + "\", \"" + team2 + "\", " +  direct + ", " + accepted + ");"

    print(sql)

    cursor.execute(sql)

    db.commit()
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

    sql = 'DELETE FROM bets WHERE bet_id=' + str(bet_id) + ';'


    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()
    db.close()

    return

def unnotified_bets(loguser):

    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)

    sql = "SELECT DISTINCT B.*, T1.logo_url AS team1_logo_url, T2.logo_url AS team2_logo_url FROM bets B "\
        "INNER JOIN teams T1 ON T1.team_full_name=B.team1 "\
          "INNER JOIN teams T2 ON T2.team_full_name=B.team2 " \
          "WHERE (user1=\"" + loguser + "\" OR user2=\"" + loguser + "\") " \
          "AND notified=0 AND winner IS NOT NULL;"

    # print(sql)

    cursor.execute(sql)

    res = []
    for row in cursor:
        res.append(row)

    # print(res)


    db.close()

    return res

def set_bet_to_notified(bet_id):

    db_config = get_db_config()
    db = pymysql.connect(db_config['host'], db_config['username'], db_config['password'], db_config['database_name'])
    cursor = db.cursor(pymysql.cursors.DictCursor)
    print(bet_id)
    sql = "UPDATE bets SET notified = 1 WHERE bet_id = " + str(bet_id) +  ";"
    cursor.execute(sql)
    db.commit()
    db.close()
    return
    

