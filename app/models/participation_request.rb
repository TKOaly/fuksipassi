class ParticipationRequest < ApplicationRecord
  belongs_to :accepter_id
  belongs_to :participant_id
  belongs_to :participation_id
end
