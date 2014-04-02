class Coordinate < ActiveRecord::Base
  belongs_to :zipcode

  validates :longitude,
    presence: true,
    length: { in: 8..10 },
    numericality: true
  validates :latitude,
    presence: true,
    length: { in: 8..10 },
    numericality: true
  validates :zipcode_id,
    presence: true
end
