class ParticipationRequest < ApplicationRecord
  belongs_to :acceptor, :class_name => 'User'
  belongs_to :participant, -> { distinct }, :class_name => 'User'
  belongs_to :participation
  has_one :event, through: :participation

  validates :participation, :presence => true
  validates :participant, :presence => true

  scope :unconfirmed, -> {where('ACCEPTOR_ID IS NULL')}
  scope :confirmed, -> {where('ACCEPTOR_ID IS NOT NULL')}
end
