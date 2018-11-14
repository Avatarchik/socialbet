loguser="isvidler"
auth="5E884898DA28047151D0E56F8DC6292773603D0D6AABBDD62A11EF721D1542D8"
url="http://165.227.180.80:5000"


if [ $1 = "open_bets" ]; then
    curl -X GET $url/api/feeds/open_bets/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "live_bets" ]; then
    curl -X GET $url/api/feeds/live_bets/\?loguser=$loguser\&auth=$auth
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



if [ $1 = "get_teams" ]; then
    curl -X GET $url/api/teams/\?loguser=$loguser\&auth=$auth
fi


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
    #TODO
    curl -X GET $url/api/feeds/open_bets/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "" ]; then
    #TODO
    curl -X GET $url/api/feeds/open_bets/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "add_friends" ]; then
    # Testing add_friend in db.py
    username=$loguser
    user1=$loguser
    user2="achapp"

    curl -X POST -H "Content-Type: application/json" $url/api/users/add_friend/ \
        -d "{\"username\": \"$username\", \"auth\": \"$auth\", \"user1\": \"$user1\", \"user2\": \"$user2\" }"
fi
