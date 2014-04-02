class Zipcode < ActiveRecord::Base
  validates :name, presence: true
end
