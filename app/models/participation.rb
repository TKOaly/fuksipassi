class Participation < ApplicationRecord
  enum participation_type: [:event, :event_extra, :task]
  belongs_to :event, required: false
  has_many :participation_requests, dependent: :destroy
  has_many :users, through: :participation_requests

  scope :tasks, -> { where('PARTICIPATION_TYPE = 2') }
  scope :events, -> {where('participation_type = 0')  }
  scope :events_and_tasks, -> {where('participation_type = 0 OR participation_type = 2')  }
  scope :for_freshers, -> { where(fresher_can_participate: true)  }
  scope :for_tutors, -> { where(tutor_can_participate: true)  }
  scope :for_freshers_strictly, -> { where(tutor_can_participate: false)  }
  scope :for_tutors_strictly, -> { where(fresher_can_participate: false)  }
  scope :extras, -> { where('PARTICIPATION_TYPE = 1') }
  scope :events, -> { where('PARTICIPATION_TYPE = 0') }

  validates :points,
            presence: true
  validates :participation_type,
            presence: true
  validate :someone_can_participate

  def unconfirmed_count
    participation_requests.unconfirmed.count
  end

  def can_participate?(user)
    if user.has_role? :fuksi and self.fresher_can_participate
      return true
    end
    if user.has_role? :tutor and self.tutor_can_participate
      return true
    end
    return false
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

  def event_points
    points
  end

  def someone_can_participate
    unless fresher_can_participate || tutor_can_participate
      errors.add(:points, 'Someone needs to be able to participate')
    end
  end

end
