class WeatherController < ApplicationController
  @current_user = "no user"
  before do
    @id = session[:user_id]
    @current_user = Account[session[:user_id]]
    puts 'wwwwwwww'
    puts @current_user
    p session[:user_id]
    puts 'wwwwwwww'
  end

  get '/' do

    @weathers = @current_user.weathers
    puts '==========='


    puts @weathers
    puts '==========='
    @forecasts = []
    puts '==========='
    puts @forecasts
    puts '==========='
    @weathers.each do |weather|
      # 1. get the forecase for each user's zip code
      puts weather.id
      puts ' -------- weather id'
      @forecasts.push get_forecast(weather.area, weather.id)
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
      minTomorTemp: temp['daily']['data'][1]['temperatureMin'],
      id: weather_id
    }
  end

  post '/delete' do

    @weather = Weather[:id => params[:weather_id]]
    @weather.destroy

    redirect '/weather'

  #   # erb :weather
  # end
  end

  post '/' do

    if session[:user_id] == nil
      p 'not logged in'
      redirect '/accounts'
    end

    zips = params[:area]
    @weathers = @current_user.add_weather(area: params[:area]).save
        # @weather = Weather.create area: zips




    redirect '/weather'

        # @weathers = Weather.all

  end
end
