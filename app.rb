require 'sinatra/base'
require "sinatra/config_file"
# require "sinatra/reloader"
require "sinatra/namespace"

require 'i18n'
require 'i18n/backend/fallbacks'

# require 'rack/contrib'


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
  register Sinatra::Namespace

  # If required sinatra/reloader
  # configure :development do
  #   register Sinatra::Reloader
  # end

  config_file './config/config.yml'
  set :root, File.dirname(__FILE__)

  # I18n config
  configure do
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
  register Sinatra::MyApp::Controllers::Welcome
  register Sinatra::MyApp::Controllers::Auth

  # start the server if ruby file executed directly
  run! if app_file == $0
end
