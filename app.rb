require 'sinatra/base'
require "sinatra/config_file"
require "sinatra/namespace"

require 'i18n'
require 'i18n/backend/fallbacks'

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
  register Sinatra::ConfigFile
  register Sinatra::Namespace

  # SOME OTHER BASIC CONFIGURATIONS
  config_file './config/config.yml'
  set :root, File.dirname(__FILE__)

  configure do
    # LOGGING CONFIGURATION
    enable :logging
    @file = File.new("#{settings.root}/logs/#{settings.environment}.log", 'a+')
    @file.sync = true
    use Rack::CommonLogger, @file
    DB.logger = [Logger.new(@file), Logger.new($stdout)]

    # I18n config
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
    I18n.backend.load_translations
    I18n.enforce_available_locales = false
    I18n.default_locale = :en
  end

  # If no locale in url, redirect to url with locale
  before do
    # check url with locale
    match = request.path.match /\/\w{2}\//
    if match.nil?
      # Get browser language code or nil
      match2 = request.env['HTTP_ACCEPT_LANGUAGE'].nil? ? nil : request.env['HTTP_ACCEPT_LANGUAGE'].match(/\w{2}/)
      redirect "/#{match2 || I18n.default_locale}" + request.path_info
    end
  end

  # Set locale per url
  before '/:locale/*' do
    I18n.locale       = params[:locale]
    request.path_info = '/' + params[:splat][0]
  end


  enable :sessions

  helpers Sinatra::MyApp::Helpers

  # Routes
  # Defining all routes here helps to avoid name colision
  # blocks are passed by reference with '&' key
  get '/', &WelcomeController.index

  get  '/login', &AuthController.login
  post  '/signin', &AuthController.signin

  get  '/signup', &AuthController.signup
  post  '/signup', &AuthController.signup_post

  get  '/signout', &AuthController.signout
  post  '/signout', &AuthController.signout_post


  # start the server if ruby file executed directly
  run! if app_file == $0
end
