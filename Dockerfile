FROM jruby:9.1.6-alpine
# FROM ruby:2.3.3

# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs \
# 		&& mkdir /myapp

WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

# RUN bundle install
RUN bundle install --without test development
ADD . /myapp
