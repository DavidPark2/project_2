class WeatherController < ApplicationController

  get '/' do
    erb :weather
  end

  post '/' do
    @weather = Account.create username: params[:username], email: params[:email], password: password
    @weathers = Weather.all
    erb :weather
  end
end
