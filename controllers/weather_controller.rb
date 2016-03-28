class WeatherController < ApplicationController

  get '/' do
    erb :weather
  end
end
