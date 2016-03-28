class ApplicationController < Sinatra::Base
  #
  # require 'bundler'
  # Bundler.require
  #
  # ActiveRecord::Base.establish_connection(
  #   :adapter => 'postgresql',
  #   :database => 'weathers_website'
  # )

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  enable :sessions

  get '/' do
    erb :account_create
  end

end
