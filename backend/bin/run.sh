#!/bin/bash
# run.sh
# starts the server

export FLASK_DEBUG=True
export FLASK_APP=api

# stop the server if it is running already
pkill gunicorn
lsof -i :5000

# (re)run the development server on port 8000
gunicorn --bind 0.0.0.0:5000 app:app --log-level=debug
