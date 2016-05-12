class WeatherController < ApplicationController

  before do
    # @id = session[:user_id]
    @current_user = Account[session[:user_id]]
  end

  get '/' do
    @weathers = @current_user.weathers
    @forecasts = []
    @weathers.each do |weather|
      @forecasts.push get_forecast(weather.area, weather.id)
      session[:user_location] = weather.area
      p session[:user_location]
    end
    erb :weather
  end

# This method get API
  def get_forecast(zip_code, weather_id)
    # This gets lat and long from google geocode
    location = RestClient.get 'https://maps.googleapis.com/maps/api/geocode/json?address=' + zip_code + "&=key" + ENV['MAPS_KEY']
    coordinates = JSON.parse(location)
    city = coordinates['results'][0]['formatted_address']
    coordinates =  coordinates['results'][0]['geometry']['location']
    lat = coordinates['lat'].to_s
    lng = coordinates['lng'].to_s
    # This uses lat and long to get weather from forecast.io
    temps = RestClient.get 'https://api.forecast.io/forecast/' + ENV['FORECAST'] + '/' + lat + ',' + lng
    temp = JSON.parse(temps)
    {
      # curdate: DateTime.strptime(curDate, '%s'),
      timeZone: city, # this is the location data; todo: refactor/rename db table column
      curSum: temp['currently']['summary'],
      curTemp: temp['currently']['temperature'],
      curPrecip: temp['daily']['data'][0]['precipProbability'],
      maxTomorTemp: temp['daily']['data'][1]['temperatureMax'],
      minTomorTemp: temp['daily']['data'][1]['temperatureMin'],
      id: weather_id
    }
  end

  # Delete weather
  post '/delete' do
    @weather = Weather[:id => params[:weather_id]]
    @weather.destroy
    redirect '/weather'
  end


  post '/' do
    if session[:user_id] == nil
      redirect '/accounts'
    end
    zips = params[:area]
    @weathers = @current_user.add_weather(area: params[:area]).save
    redirect '/weather'
  end
end
