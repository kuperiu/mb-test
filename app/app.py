#!/usr/bin/env python
import sys
import logging
import requests
from flask import Flask, send_file, Response, request, jsonify
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
app.logger.addHandler(logging.StreamHandler(sys.stdout))
app.logger.setLevel(logging.DEBUG)
app.logger.addHandler(logging.StreamHandler(sys.stdout))
app.logger.setLevel(logging.DEBUG)

metrics = PrometheusMetrics(app)
endpoints = ('homersimpson', 'covilha')

@app.route('/homersimpson')
@metrics.counter('invocation_by_type', 'Number of invocations by type')
def homersimpson():
    filename = 'static/simpsons.jpg'
    return send_file(filename, mimetype='image/jpg')


@app.route('/covilha')
def covilha():
    try:
        url = 'http://worldtimeapi.org/api/timezone/Europe/Lisbon'
        res = requests.get(url, timeout=10.0)
    except:
        res = None
    if res and res.status_code == 200:
        dt = res.json()
        return dt['datetime']
    else:
        message = "Couldn't get time from worldtimeapi"
        resp = jsonify(message)
        resp.status_code = 500
        return resp


@app.route('/health')
def health():
    return 'app is healthy'


class Writer(object):
    def __init__(self, filename):
        self.file = open(filename,'w')

    def write(self, data):
        self.file.write(data)

    def flush(self):
        self.file.flush()

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("usage: %s port" % (sys.argv[0]))
        sys.exit(-1)

    p = int(sys.argv[1])
    sys.stderr = Writer('stderr.log')
    sys.stdout = Writer('stdout.log')
    print("start at port %s" % (p))
    app.run(host='0.0.0.0', port=p, threaded=True)