require 'sinatra/base'
require 'sinatra/json'
# require "sinatra/config_file" # config file, I don't really need it
# require "sinatra/namespace" # namespace for routes


require './controllers/base'

required_dirs = [
  './config/app/*.rb',
  './helpers/*.rb',
  './models/*.rb',
  './controllers/*.rb',
]

required_dirs.each do |dir|
  Dir[dir].each {|file| require file }
end

require './config/setup'


class MyApp < Sinatra::Base
  # register Sinatra::ConfigFile
  # register Sinatra::Namespace

  # SOME OTHER BASIC CONFIGURATIONS
  # config_file './config/config.yml'
  # set :root, File.dirname(__FILE__)

  configure :development do
    set :port, 3000
    # LOGGING CONFIGURATION
    enable :logging
    @file = File.new("#{settings.root}/logs/#{settings.environment}.log", 'a+')
    @file.sync = true
    use Rack::CommonLogger, @file
    DB.logger = [Logger.new(@file), Logger.new($stdout)]

  end

  configure do
    # I18n
    # require 'i18n'
    # require 'i18n/backend/fallbacks'

    # I18n config
    # I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    # I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
    # I18n.backend.load_translations
    # I18n.enforce_available_locales = false
    # I18n.default_locale = :en

    case RUBY_PLATFORM
    when 'java'
    	require 'jrjackson'
    	set :json_encoder, JrJackson::Json
    else
    	require 'oj'
    	Oj.default_options = {:mode => :compat }
      # set :json_encoder, Oj
    end

    # IF cors needed
    # require 'rack/cors'
    # use Rack::Cors do
    #   allow do
    #     origins '*'
    #     resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
    #   end
    # end

  end

  # before do
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  # enable :sessions # not for apis

  helpers Sinatra::MyApp::Helpers

  # Routes
  # Defining all routes here helps to avoid name colision
  # blocks are passed by reference with '&' key
  get '/', &WelcomeController.index
  get '/json', &WelcomeController.json


  run! if app_file == $0
end
