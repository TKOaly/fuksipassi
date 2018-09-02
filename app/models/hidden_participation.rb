class HiddenParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :participation

  validates :user,
            presence: true,
            associated: true
  validates :participation,
            presence: true,
            associated: true
end