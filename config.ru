# require 'sinatra/base'
#
# require './controllers/application'
#
# map('/') { run ApplicationController }

require 'bundler'
Bundler.require

DB = Sequel.sqlite('development.sqlite')

require './controllers/application_controller'

map('/') { run ApplicationController }
