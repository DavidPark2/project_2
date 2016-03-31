source 'https://rubygems.org'

# gem 'sinatra', '~> 1.4', '>= 1.4.7'
# gem 'rerun', '~> 0.11.0'
# gem 'pg', '~> 0.18.4'
# gem 'sinatra-activerecord', '~> 2.0', '>= 2.0.9'

gem 'sinatra', '~> 1.4', '>= 1.4.7', require: 'sinatra/base'
gem 'sequel', '~> 4.32'
gem 'thin', '~> 1.6', '>= 1.6.4'
gem 'bcrypt', '~> 3.1', '>= 3.1.11'
gem 'forecast_io'
gem 'rest-client', '~> 1.8'
gem 'json', '~> 1.8', '>= 1.8.3'
gem 'dotenv', '~> 2.1', '>= 2.1.1'
gem 'pry'

group :development, :test do
  gem 'rerun', '~> 0.11.0'
  gem 'sqlite3', '~> 1.3', '>= 1.3.11'
end

group :production do
  gem 'pg', '~> 0.18.4'
end
