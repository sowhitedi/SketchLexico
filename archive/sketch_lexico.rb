# Get ready to kick ass.
require 'sinatra'
require 'sinatra/i18n'
require 'haml'
require 'sass'
require 'compass'

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
end

configure :production do
  require 'newrelic_rpm'
end

get '/' do
  set :locales, File.join(File.dirname(__FILE__), "config/locales/en.yml")
  Sinatra.register Sinatra::I18n
  haml :index
end

# LOCALE STUFF
get '/:locale' do |locale|
  set :locales, File.join(File.dirname(__FILE__), "config/locales/#{locale}.yml")
  Sinatra.register Sinatra::I18n
  haml :index
end

# STYLESHEETS
get '/stylesheets/:name.css' do
  content_type 'text/css', charset: 'utf-8'
  scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
end