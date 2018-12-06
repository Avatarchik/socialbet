cd ~/socialbet/backend
pkill python3
python3 sports_api_app.py &
pkill gunicorn
gunicorn --bind 0.0.0.0:5000 app:app --log-level=debug
