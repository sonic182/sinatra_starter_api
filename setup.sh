#!/bin/bash

case $1 in
"web:deploy")
docker-compose build web; docker-compose up --no-deps -d web; docker-compose restart nginx
;;
"nginx:deploy")
docker-compose build nginx; docker-compose up --no-deps -d nginx
;;
"migrate")
docker-compose exec web rake db:migrate
;;
esac
