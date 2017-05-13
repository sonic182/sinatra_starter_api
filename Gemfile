source 'https://rubygems.org'

gem 'sequel', '~> 4.42.0'
gem 'sinatra', '~> 1.4.7'
gem 'sinatra-contrib', '~> 1.4.7'

gem 'puma', '~> 3.6.0'
gem 'rack-cors', require: nil

gem 'bcrypt', '~> 3.1.6'

# optimized json serializer ruby
gem 'oj', platform: :ruby

# optimized json serializer jruby
gem 'jrjackson', platform: :jruby

group :development do
  gem 'jdbc-sqlite3', '~> 3.15.1', platform: :jruby
  gem 'sqlite3', '~> 1.3.12', platform: :ruby
end

group :production do
  gem 'jdbc-postgres', platform: :jruby
  gem 'pg', platform: :ruby
end
