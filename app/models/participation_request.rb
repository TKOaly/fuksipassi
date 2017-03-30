class ParticipationRequest < ApplicationRecord
  belongs_to :acceptor, :class_name => 'User', :foreign_key => 'acceptor_id'
  belongs_to :participant, :class_name => 'User', :foreign_key => 'participant_id'
  belongs_to :participation
  has_one :event, through: :participation
  # has_one :points, through: :participation

  scope :unconfirmed, -> {where('ACCEPTOR_ID IS NULL')}
  scope :confirmed, -> {where('ACCEPTOR_ID IS NOT NULL')}
end
