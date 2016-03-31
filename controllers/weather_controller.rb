class WeatherController < ApplicationController
  before do
    @current_user = Account[session[:user_id]]
  end

  get '/' do

    @weathers = @current_user.weathers
    puts @weathers
    @forecasts = []
    @weathers.each do |weather|
      # 1. get the forecase for each user's zip code
      @forecasts.push get_forecast(weather.zip)
      # 2. Save the forecast into an array

      # 3. Make array of forecasts available to the view by making it an @instance variable
    end

    erb :weather
  end


  def get_forecast(zip_code)
    location = RestClient.get 'https://maps.googleapis.com/maps/api/geocode/json?address=' + zip_code + "&=key" + ENV['MAPS_KEY']

    coordinates = JSON.parse(location)
    # puts coordinates
    # puts zips
    # puts '-------------coords======'
    coordinates =  coordinates['results'][0]['geometry']['location']

    lat = coordinates['lat'].to_s
    lng = coordinates['lng'].to_s

    temps = RestClient.get 'https://api.forecast.io/forecast/' + ENV['FORECAST'] + '/' + lat + ',' + lng

    temp = JSON.parse(temps)

    # Current Date
    curDate = temp['currently']['time'].to_s
    # curDate = DateTime.strptime(curDate, '%s')

    {
      curdate: DateTime.strptime(curDate, '%s'),
      timeZone: temp['timezone'],
      curSum: temp['currently']['summary'],
      curTemp: temp['currently']['temperature'],
      curPrecip: temp['currently']['precipProbability'],
      maxTomorTemp: temp['daily']['data'][1]['temperatureMax'],
      minTomorTemp: temp['daily']['data'][1]['temperatureMin']
    }
  end

  post '/' do
    # zips = params[:zips]
    # @weather = Weather.create area: zips
    #
    # redirect '/weather'

    @weathers = Weather.all

    erb :weather
  end

end
