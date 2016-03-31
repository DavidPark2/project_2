class Weather < Sequel::Model
  plugin :composition
  one_to_many :accounts
end
