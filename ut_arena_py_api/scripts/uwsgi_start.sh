#!/bin/bash -u

APP_HOME=/opt/ut-arena/

exec uwsgi --socket ut-arena.sock --chdir=/opt/ut-arena/ --module ut_arena.wsgi:application --processes 2 -t 60 --disable-logging -M --need-app -b 32768 --chmod-socket=666