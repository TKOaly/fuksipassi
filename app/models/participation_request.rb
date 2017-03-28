class ParticipationRequest < ApplicationRecord
  belongs_to :acceptor, :class_name => 'User', :foreign_key => 'acceptor_id'
  belongs_to :participant, :class_name => 'User', :foreign_key => 'participant_id'
  belongs_to :participation
end
