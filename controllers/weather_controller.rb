class WeatherController < ApplicationController

  get '/' do
    @weathers = Weather.all
    puts @weathers
    erb :weather
  end

  post '/' do
    @weather = Weather.create location: params[:location], temperature: params[:temperature]
    # @weather = Weather.create({
    #   :username => params[:username],
    #   :email => params[:email],
    #   :password => password
    # })

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
