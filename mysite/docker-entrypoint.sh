#!/bin/sh

set -x

PORT="${PORT:="8005"}"

set +x

python3 manage.py migrate

sed -i -e "s/PORT/${PORT}/" /var/www/mysite/uwsgi.ini

uwsgi --ini /var/www/mysite/uwsgi.ini

