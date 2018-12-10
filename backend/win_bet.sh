url="http://165.227.180.80:5000"


bet_id=1
team1_score=49
team2_score=30
winner="achapp"
curl -X POST -H "Content-Type: application/json" $url/api/betting/win_bet/ \
    -d "{\"bet_id\": \"$bet_id\", \"team1_score\": \"$team1_score\", \"team2_score\": \"$team2_score\", \"winner\": \"$winner\"}"


