loguser="achapp"
auth="5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8"
url="http://165.227.180.80:5000"


# Feed endpoints
############################

if [ $1 = "open_bets" ]; then
    curl -X GET $url/api/feeds/open_bets/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "live_bets" ]; then
    curl -X GET $url/api/feeds/live_bets/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "users_open_bets" ]; then
    curl -X GET $url/api/feeds/users_open_bets/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "users_live_bets" ]; then
    curl -X GET $url/api/feeds/users_live_bets/\?loguser=$loguser\&auth=$auth
fi


if [ $1 = "closed_bets" ]; then
    curl -X GET $url/api/feeds/closed_bets/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "direct_bets_pending" ]; then
    curl -X GET $url/api/feeds/direct_bets_pending/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "bet_history" ]; then
    curl -X GET $url/api/feeds/bet_history/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "between_us_bets" ]; then
    user2="cterech"
    curl -X GET $url/api/feeds/between_us_bets/\?loguser=$loguser\&auth=$auth\&user2=$user2
fi

if [ $1 = "unnotified_bets"]; then
    curl -X GET $url/api/games/unnotified/\?loguser=$loguser\&auth=$auth
fi

# Teams endpoints
############################

if [ $1 = "get_teams" ]; then
    curl -X GET $url/api/teams/\?loguser=$loguser\&auth=$auth
fi

# Games endpoints
############################


if [ $1 = "sports_api_emulator" ]; then
    curl -X GET $url/api/sports_api_emulator/\?loguser=$loguser\&auth=$auth
fi

# User endpoints
############################

if [ $1 = "create_user" ]; then
    username="testuser"
    auth="testauth"
    firstname="testfirstname"
    lastname="testlastname"
    phonenumber="testphonenumber"
    profile_pic_url="testprofilepicurl"
    curl -X POST -H "Content-Type: application/json" $url/api/users/create/ \
        -d "{\"username\": \"$username\", \"auth\": \"$auth\", \"firstname\": \"$firstname\", \"lastname\": \"$lastname\", \"phonenumber\": \"$phonenumber\", \"profile_pic_url\": \"$profile_pic_url\" }"

fi

if [ $1 = "user_exists" ]; then
    curl -X GET $url/api/users/exists/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "add_friends" ]; then
    # Testing add_friend in db.py
    username=$loguser
    user1=$loguser
    user2="achapp"

    curl -X POST -H "Content-Type: application/json" $url/api/users/add_friend/ \
        -d "{\"loguser\": \"$username\", \"auth\": \"$auth\", \"user1\": \"$user1\", \"user2\": \"$user2\" }"
fi

if [ $1 = "get_user" ]; then
    username="achapp"
    curl -X GET $url/api/users/find/\?loguser=$loguser\&auth=$auth\&username=$username
fi

# Betting endpoints
#########################

if [ $1 = "place_bet" ]; then
    game_id=3
    message="fuck yeah test worked"
    amount="\$420.69"
    user2="cterech"
    direct=1
    accepted=0
    time_placed="this is a date"
    

    curl -X POST -H "Content-Type: application/json" $url/api/betting/place_bet/ \
        -d "{\"loguser\": \"$loguser\", \"auth\": \"$auth\", \"game_id\": \"$game_id\", \"message\": \"$message\", \"amount\": \"$amount\", \"user1\": \"$loguser\", \"user2\": \"$user2\", \"direct\": $direct, \"accepted\": $accepted, \"time_placed\": \"$time_placed\" }"

fi

if [ $1 = "accept_direct_bet" ]; then
    bet_id=5

    curl -X POST -H "Content-Type: application/json" $url/api/betting/accept_bet/ \
        -d "{\"loguser\": \"$loguser\", \"auth\": \"$auth\", \"bet_id\": $bet_id}"
fi

if [ $1 = "accept_open_bet" ]; then
    bet_id=21

    curl -X POST -H "Content-Type: application/json" $url/api/betting/accept_bet/ \
        -d "{\"loguser\": \"$loguser\", \"auth\": \"$auth\", \"bet_id\": $bet_id}"
fi

if [ $1 = "cancel_bet" ]; then
    bet_id=5

    curl -X POST -H "Content-Type: application/json" $url/api/betting/cancel_bet/ \
        -d "{\"loguser\": \"$loguser\", \"auth\": \"$auth\", \"bet_id\": \"$bet_id\"}"
fi
