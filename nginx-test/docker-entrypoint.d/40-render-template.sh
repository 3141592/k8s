#!/bin/sh
set -eu

: "${APP_ENV:?APP_ENV is required}"
: "${APP_MESSAGE:?APP_MESSAGE is required}"

envsubst '${APP_ENV} ${APP_MESSAGE}' \
  < /usr/share/nginx/html/index.html.template \
  > /usr/share/nginx/html/index.html
