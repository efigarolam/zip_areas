class Zipcode < ActiveRecord::Base
  has_many :coordinates, dependent: :destroy

  validates :name, presence: true
end

