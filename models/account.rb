# class Account < ActiveRecord::Base
#
# end

class Account < Sequel::Model
  one_to_many :weathers
end
