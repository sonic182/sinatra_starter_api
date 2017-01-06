FROM jruby:9.1.6-alpine
# FROM ruby:2.3.3

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs \
# 		&& mkdir /myapp

RUN apk add --no-cache nodejs \
		&& npm install -g yarn

WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
ADD package.json /myapp/package.json

RUN bundle install --without test development
RUN yarn install

ADD . /myapp

RUN npm run build:prod
