class Participation < ApplicationRecord
  enum participation_type: [:event, :event_extra, :task]
  belongs_to :event
  has_many :participation_requests
  has_many :users, through: :participation_requests

  scope :tasks,  -> {where('PARTICIPATION_TYPE = 2')}

  def name
    description
  end

  def to_s
    if event
      "#{event.name} - #{points}"
    else
      "#{description} - #{points}"
    end
  end
end
