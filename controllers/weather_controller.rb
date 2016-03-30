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

###############################
# API CALL
# #############################

# #########
# coordinates
# #########
location = RestClient.get 'https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyDNdMQDvtbIvoO6tNxkbs9BiS45BT_nXLE'

coordinates = JSON.parse(location)

coordinates['results'][0]['geometry']['location']

# #########
# Forecast api CALL
# #########
temps = RestClient.get 'https://api.forecast.io/forecast/d2786edc0fce4d176dfd20318726c878/37.8267,-122.423'

temp = JSON.parse(temps)

# Current Date
curDate = temp['currently']['time'].to_s
curDate = DateTime.strptime(curDate, '%s')

# Current summary
curSum = temp['currently']['summary']

# Current temp
curTemp = temp['currently']['temperature']

# Current precip
curPrecip = temp['currently']['precipProbability']

# Tomorrow temp
maxTomorTemp = temp['daily']['data'][1]['temperatureMax']
minTomorTemp = temp['daily']['data'][1]['temperatureMin']

# ##########################
# End of API CALL
# ########################
