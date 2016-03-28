require 'sinatra/base'

require './controllers/application'

map('/') { run ApplicationController }
