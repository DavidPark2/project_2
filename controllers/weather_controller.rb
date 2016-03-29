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

# create_table(:weathers) do
#   primary_key :id
#   String :location
#   String :temperature
