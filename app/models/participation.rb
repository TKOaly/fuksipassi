class Participation < ApplicationRecord
  belongs_to :event
  has_many :participation_requests
  has_many :users, through: :participation_requests

  def to_s
    if event
      "Attendance to #{event.name}"
    else
      participation
    end
  end


end
