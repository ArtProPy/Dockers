#!/bin/sh

set -x

PORT="${PORT:="8005"}"

set +x

sed -i -e "s/PORT/${PORT}/" /var/www/mysite/uwsgi.ini

uwsgi --ini /var/www/mysite/uwsgi.ini
