# class Account < ActiveRecord::Base
#
# end

class Account < Sequel::Model
  plugin :composition
  one_to_many :weathers
end
