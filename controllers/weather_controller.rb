class WeatherController < ApplicationController

  get '/' do
    erb :weather
  end

  post '/' do
    @weather = Account.create username: params[:username], email: params[:email],  password: password
    @weathers = Weather.all
    erb :weather
  end
end


# We will use this in order to get long/lad from google
# require 'rest-client'
#
# location = RestClient.get 'your url here'
#
# coordinates = JSON.parse(location.body)
#
# coordinates['latitude']
