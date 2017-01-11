###### FOR USING RUBY
# FROM ruby:2.3.3
FROM ruby:2.4.0

###### FOR USING JRUBY
# FROM jruby:9.1.6-alpine


WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
ADD package.json /myapp/package.json

RUN bundle install --without test development

ADD . /myapp

RUN chmod +x entrypoint.sh
ENTRYPOINT ["/myapp/entrypoint.sh"]
