###### FOR USING RUBY
# FROM ruby:2.3.3
FROM ruby:2.4.0
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
	&& apt-get install -y build-essential libpq-dev nodejs \
	&& npm install -g yarn \
	&& rm -rf /var/lib/apt/lists/*

###### FOR USING JRUBY
# FROM jruby:9.1.6-alpine
# RUN apk add --no-cache nodejs make \
# 		&& npm install -g yarn


WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
ADD package.json /myapp/package.json

RUN bundle install --without test development
RUN yarn install

ADD . /myapp

RUN npm run build:prod && chmod +x entrypoint.sh

ENTRYPOINT ["/myapp/entrypoint.sh"]
