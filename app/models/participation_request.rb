class ParticipationRequest < ApplicationRecord
  belongs_to :acceptor, :class_name => 'User', required: false
  belongs_to :participant, -> { distinct }, :class_name => 'User'
  belongs_to :participation
  has_one :event, through: :participation, required: false

  validates :participant,
            presence: true,
            associated: true
  validates :participation,
            presence: true,
            associated: true
  validates_uniqueness_of :participant, scope: :participation

  validate :participation_not_in_future

  scope :unconfirmed, -> { where('ACCEPTOR_ID IS NULL') }
  scope :confirmed, -> { where('ACCEPTOR_ID IS NOT NULL') }

  def participation_not_in_future
    if participation && participation.event && participation.event.date && participation.event.date > Time.now.utc.to_date
      errors.add(:participation_request, 'Event has not taken place yet!')
    end
  end
end


