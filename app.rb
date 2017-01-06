require 'sinatra/base'
require "sinatra/config_file"
require "sinatra/reloader"

required_dirs = [
  './controllers/*.rb',
  './helpers/*.rb',
  './config/*.rb',
]

required_dirs.each do |dir|
  Dir[dir].each {|file| require file }
end

class MyApp < Sinatra::Base
  register Sinatra::ConfigFile

  configure :development do
    register Sinatra::Reloader
  end

  config_file './config/config.yml'
  set :root, File.dirname(__FILE__)

  enable :sessions

  helpers Sinatra::MyApp::Helpers
  register Sinatra::MyApp::Controllers::Welcome

  # start the server if ruby file executed directly
  run! if app_file == $0
end
