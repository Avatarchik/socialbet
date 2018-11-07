#!/bin/bash
# run.sh
# starts the server

export FLASK_DEBUG=True
export FLASK_APP=api

# run the development server on port 8000
flask run --host 0.0.0.0 --port 8000
