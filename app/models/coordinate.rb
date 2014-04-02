class Coordinate < ActiveRecord::Base
  belongs_to :zipcode

  validates :longitude, presence: true, numericality: true
  validates :latitude, presence: true, numericality: true
  validates :zipcode_id, presence: true
end

