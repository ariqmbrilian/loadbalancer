import os
import redis
from flask import Flask

app = Flask(__name__)
app_name = os.getenv('APP_NAME', 'default')
cache = redis.Redis(host='redis', port=6379)

def get_hit_count():
    return cache.incr('hits')

@app.route('/')
def hello():
    count = get_hit_count()
    return f'{app_name} been seen {count} time.\n'