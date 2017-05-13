require 'sequel'
require 'bcrypt'
require 'logger'

Sequel::Model.plugin :timestamps
Sequel::Model.plugin :dirty
Sequel::Model.plugin :validation_helpers
# Sequel::Model.plugin :before_after_save

if ENV['DATABASE_URL']
  url = ENV['DATABASE_URL']
  url = RUBY_PLATFORM == 'java' ? 'jdbc:' + url : url
  DB = Sequel.connect(url)
else
  # DB = RUBY_PLATFORM == "java" ? Sequel.connect('jdbc:sqlite::memory') : Sequel.sqlite # for in memory sqlite3
  DB = RUBY_PLATFORM == 'java' ? Sequel.connect('jdbc:sqlite:db.sqlite3') : Sequel.sqlite('db.sqlite3')
  DB.sql_log_level = :debug
end
