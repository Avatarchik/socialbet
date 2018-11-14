loguser="isvidler"
auth="382HF89EHN29E9321AA"
url="http://165.227.180.80:5000"


if [ $1 = "open_bets" ]; then
    curl -X GET $url/api/feeds/open_bets/\?loguser=$loguser\&auth=$auth
fi

if [ $1 = "live_bets" ]; then
    curl -X GET $url/api/feeds/live_bets/\?loguser=$loguser\&auth=$auth
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
