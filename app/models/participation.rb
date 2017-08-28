class Participation < ApplicationRecord
  enum participation_type: [:event, :event_extra, :task]
  belongs_to :event
  has_many :participation_requests, dependent: :destroy
  has_many :users, through: :participation_requests

  scope :tasks, -> { where('PARTICIPATION_TYPE = 2') }
  scope :events_and_tasks, -> {where('participation_type = 0 OR participation_type = 2')  }
  scope :extras, -> { where('PARTICIPATION_TYPE = 1') }
  scope :events, -> { where('PARTICIPATION_TYPE = 0') }

  validates :points,
            presence: true
  validates :participation_type,
            presence: true

  def unconfirmed_count
    participation_requests.unconfirmed.count
  end

  def name
    if participation_type == 'event'
      event.name
    elsif participation_type == 'event_extra'
      "#{event.name} - #{description}"
    elsif participation_type == 'task'
      description
    end
  end

  def to_s
    if participation_type == 'event'
      "#{event.name} - #{points}"
    elsif participation_type == 'event_extra'
      "#{description} - #{points}"
    elsif participation_type == 'task'
      "#{description} - #{points}"
    end
  end



end
