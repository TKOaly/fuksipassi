class Event < ApplicationRecord
  has_many :participations
  belongs_to :year
end
