class ParticipationRequest < ApplicationRecord
  belongs_to :acceptor, :class_name => 'User'
  belongs_to :participant, -> { distinct }, :class_name => 'User'
  belongs_to :participation
  has_one :event, through: :participation

  validates :participation, :presence => true
  validates :participant, :presence => true
  validate :participation_not_in_future

  scope :unconfirmed, -> { where('ACCEPTOR_ID IS NULL') }
  scope :confirmed, -> { where('ACCEPTOR_ID IS NOT NULL') }
  scope :participations_with_unconfirmed, -> { unconfirmed.map { |p| p.participation }.uniq.map { |event| event.participation_requests.unconfirmed } }

  def participation_not_in_future
    if participation&.event.date > Date.today
      errors.add(:participation_request, 'Event has not taken place yet!')
    end
  end
end


