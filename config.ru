# require 'sinatra/base'
#
# require './controllers/application'
#
# map('/') { run ApplicationController }
ENV['RACK_ENV'] ||= 'development'
require 'bundler'
require 'date'
Bundler.require

DB = Sequel.sqlite('development.sqlite')

require './models/account'
require './models/weather'

require './controllers/application_controller'
require './controllers/accounts_controller'
require './controllers/weather_controller'

map('/') { run ApplicationController }
map('/accounts') { run AccountController }
map('/weather') { run WeatherController }
