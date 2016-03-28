# require 'sinatra/base'
#
# require './controllers/application'
#
# map('/') { run ApplicationController }

require 'bundler'
Bundler.require

DB = Sequel.sqlite('development.sqlite')

require './models/user'

require './controllers/application_controller'
require './controllers/accounts_controller'
require './controllers/weather_controller'

map('/') { run ApplicationController }
map('/accounts') { run AccountsController }
map('/weather') { run WeatherController }
