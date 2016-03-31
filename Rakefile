ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

desc "Load the environment"
task :environment do
  ENV['RACK_ENV'] ||= 'development'

  DB = if ENV['RACK_ENV'] == 'production'
    Sequel.connect(ENV['DATABASE_URL'])
  else
    Sequel.sqlite('development.sqlite')
  end
end

namespace :db do
  desc "Migrate the database"
  task :migrate => [:environment] do
    Sequel.extension :migration

    puts "Running migrations..."
    Sequel::Migrator.run(DB, 'migrations/')
  end
end
